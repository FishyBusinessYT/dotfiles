local M = {}

-- Technically configurable, but this is only defined here to avoid
-- 'magic number'ing. I intend to keep this value untouched.
local MAX_PROJECTS = 15
local HOUR = 60 * 60
local DAY = 24 * HOUR
local WEEK = 7 * DAY

local data_path = vim.fn.stdpath('data') .. '/project-list.json'

local visited_projects = {} -- Per-session
local buf_roots = {} -- Maps buffers to `root_dir`s

local function frecency(entry)
    local age = os.time() - entry.last_accessed
    if age < HOUR then
        return entry.score * 4
    elseif age < DAY then
        return entry.score * 2
    elseif age < WEEK then
        return entry.score / 2
    else
        return entry.score / 4
    end
end

local function sort_by_frecency(entries)
    table.sort(entries, function(a, b) return frecency(a) > frecency(b) end)
end

local function get_entries()
    if vim.fn.filereadable(data_path) == 0 then return {} end

    local lines = vim.fn.readfile(data_path)
    if #lines == 0 then return {} end -- lines = {} in this case anyway

    -- Entire JSON is stored in one line
    local ok_decode, decoded = pcall(vim.fn.json_decode, lines[1])

    -- Could theoretically happen if DB file is tampered with/corrupted
    if not ok_decode or type(decoded) ~= 'table' then
        vim.notify(
            'project-list: error decoding DB, starting fresh',
            vim.log.levels.WARN
        )
        return {}
    end

    return decoded
end

local function write_db(entries)
    -- No pcalls needed here since entries should be properly handled everywhere
    -- else, and data_path is standardized, so no permissions issues should ever
    -- arise.
    -- Also, entries is already sorted, so there's no need to sort it again
    -- here OR when reading the DB
    local encoded = vim.fn.json_encode(entries)
    vim.fn.writefile({ encoded }, data_path)
end

--- Record one access to `path`. No-ops if this project was already accessed
--- earlier in the current session.
local function record_access(path)
    if visited_projects[path] then return end
    visited_projects[path] = true

    local entries = get_entries()

    local found_entry
    for _, entry in ipairs(entries) do
        if entry.path == path then
            found_entry = entry
            break
        end
    end

    local now = os.time()
    if found_entry then
        found_entry.score = found_entry.score + 1
        found_entry.last_accessed = now
    else
        table.insert(entries, { path = path, score = 1, last_accessed = now })
    end

    sort_by_frecency(entries)

    -- Only one entry is added at a time, so we can just drop the possible
    -- extra element safely without ever even checking if it's there.
    entries[MAX_PROJECTS + 1] = nil

    write_db(entries)
end

--- Resolve root_dir for a buffer, prompting only if this buffer has already
--- resolved to a *different* root_dir before.
local function get_root_dir(bufnr, client)
    -- Try to get root_dir from LSP client
    local root_dir = client.config and client.config.root_dir
    -- If that doesn't work fallback to dir containing git repo
    if not root_dir then root_dir = vim.fs.root(bufnr, { '.git' }) end
    -- If that fails we'll assume the buffer does not belong to a project at all.
    if not root_dir then return nil end

    root_dir = vim.fs.normalize(root_dir)

    local cached_rd = buf_roots[bufnr]
    if cached_rd == nil or cached_rd == root_dir then
        buf_roots[bufnr] = root_dir
        return root_dir
    end

    local prompt = [[project-list: Please select project root dir:
    Default: %s
    [N]ew: %s
    > ]]
    -- Conflict: ask which one to trust.
    local input = vim.fn.input(string.format(prompt, cached_rd, root_dir))
    -- Rough tests show that the prompt is auto-cleared.
    -- TODO verify if this next line is actually needed.
    -- vim.cmd('redraw')

    -- Default to cached dir unless user enters 'n'
    local selection = (string.lower(input) == 'n') and root_dir or cached_rd
    buf_roots[bufnr] = selection
    return selection
end

function M.setup()
    vim.api.nvim_create_autocmd('LspAttach', {
        -- This ensures the autocommand will not stack, just in case setup is
        -- ever called more than once per neovim session.
        group = vim.api.nvim_create_augroup('project-list', { clear = true }),
        callback = function(args)
            local client = vim.lsp.get_client_by_id(args.data.client_id)
            -- Can happen if the LSP fails to start for some reason
            if not client then return end

            local root_dir = get_root_dir(args.buf, client)
            if root_dir then record_access(root_dir) end
        end,
    })
end

--- Returns up to 12 project paths, sorted by frecency (highest first).
function M.get_projects()
    local paths = {}
    for _, e in ipairs(get_entries()) do
        table.insert(paths, e.path)
    end
    return paths
end

return M
