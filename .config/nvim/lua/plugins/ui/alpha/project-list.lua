local M = {}

-- Technically configurable, but this is only defined here to avoid
-- 'magic number'ing. I intend to keep this value untouched.
local MAX_PROJECTS = 15
local HOUR = 60 * 60
local DAY = 24 * HOUR
local WEEK = 7 * DAY

local data_path = vim.fs.joinpath(vim.fn.stdpath('data'), 'project-list.json')

local visited_projects = {} -- Per-session

-- FRECENCY
local function frecency(entry, now)
    local age = now - entry.last_accessed
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
    -- Pinning this to keep it consistent across every element
    local now = os.time()
    table.sort(entries, function(a, b)
        local fa, fb = frecency(a, now), frecency(b, now)
        if fa == fb then return a.last_accessed > b.last_accessed end
        return fa > fb
    end)
end

-- PERSISTENCE
local function read_db()
    if vim.fn.filereadable(data_path) == 0 then return {} end

    local ok_read, lines = pcall(vim.fn.readfile, data_path)
    if not ok_read or #lines == 0 then return {} end

    -- Entire JSON is stored in one line
    local ok_decode, decoded = pcall(vim.json.decode, lines[1])

    -- Could theoretically happen if DB file is tampered with/corrupted
    if not ok_decode or type(decoded) ~= 'table' then
        vim.notify(
            'project-list: error decoding DB, starting fresh',
            vim.log.levels.WARN
        )
        return {}
    end

    -- Sort on read to account for time decay
    sort_by_frecency(decoded)
    return decoded
end

local function write_db(entries)
    -- Entries are sorted on read due to score decay, so there's no point to
    -- sort them here.
    local encoded = vim.json.encode(entries)

    local ok_write, err = pcall(vim.fn.writefile, { encoded }, data_path)
    if not ok_write then
        vim.notify(
            'project-list: failed to write DB: ' .. tostring(err),
            vim.log.levels.ERROR
        )
    end
end

-- LOGIC
-- Record one access to `path`. No-ops if this project was already accessed
-- earlier in the current session.
local function record_access(path)
    if not path then return end
    if visited_projects[path] then return end
    visited_projects[path] = true

    local project_list = read_db()

    local found_entry
    for _, entry in ipairs(project_list) do
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
        table.insert(
            project_list,
            { path = path, score = 1, last_accessed = now }
        )
    end

    sort_by_frecency(project_list)

    -- Even though only one entry is added at a time, the DB file could be
    -- tampered with, MAX_PROJECTS could be reduced by an arbitrary amount, etc.
    -- This is safer.
    for i = #project_list, MAX_PROJECTS + 1, -1 do
        project_list[i] = nil
    end

    write_db(project_list)
end

-- Resolve root_dir for a buffer
local function get_root_dir(bufnr)
    local git_dir = vim.fs.root(bufnr, { '.git' })
    if git_dir then git_dir = vim.fs.normalize(git_dir) end
    return git_dir
end

function M.setup()
    vim.api.nvim_create_autocmd('FileType', {
        -- This ensures the autocommand will not stack, just in case setup is
        -- ever called more than once per neovim session.
        group = vim.api.nvim_create_augroup('project-list', { clear = true }),

        callback = function(args)
            local bufnr = args.buf
            if vim.bo[bufnr].buftype ~= '' then return end

            -- Ensure buffer is still valid before continuing
            if not vim.api.nvim_buf_is_valid(bufnr) then return end

            local root_dir = get_root_dir(bufnr)
            if root_dir then record_access(root_dir) end
        end,
    })
end

-- Returns all stored project paths, sorted by frecency (highest first).
function M.get_projects()
    local paths = {}
    for _, e in ipairs(read_db()) do
        table.insert(paths, e.path)
    end
    return paths
end

return M
