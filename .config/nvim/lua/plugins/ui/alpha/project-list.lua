--- project_frecency.lua
---
--- Tracks projects (LSP root_dir) by frecency, zoxide-style, and persists them
--- as JSON under stdpath("data"). No UI, no lifetime management — just data.
---
--- Usage in your config:
---
---   require("project_frecency").setup()
---
---   -- later, e.g. wired into your own picker:
---   local entries = require("project_frecency").get_entries()
---   -- entries = { { path = "...", score = 3, last_accessed = 1234567890 }, ... }
---   -- sorted by frecency, highest first
---
--- References:
---   Frecency algorithm: https://github.com/ajeetdsouza/zoxide/wiki/Algorithm
---   :h LspAttach
---   :h vim.fs.root()
---   :h vim.lsp.get_client_by_id()
---   :h stdpath()
---   :h json_encode() / :h json_decode()
---   :h readfile() / :h writefile()

local M = {}

local MAX_PROJECTS = 12
local HOUR = 60 * 60
local DAY = 24 * HOUR
local WEEK = 7 * DAY

local data_path = vim.fn.stdpath("data") .. "/project_frecency.json"

-- Session-only state (reset every time Neovim starts, by design).
local seen_this_session = {} -- [root_dir] = true, enforces "one access per project per session"
local buf_root = {} -- [bufnr] = root_dir already resolved for that buffer this session

--- zoxide's frecency weighting: raw visit count, decayed by recency.
--- https://github.com/ajeetdsouza/zoxide/wiki/Algorithm
local function frecency_score(entry, now)
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
  local now = os.time()
  table.sort(entries, function(a, b)
    return frecency_score(a, now) > frecency_score(b, now)
  end)
end

local function read_db()
  if vim.fn.filereadable(data_path) == 0 then
    return {}
  end

  local ok_read, lines = pcall(vim.fn.readfile, data_path)
  if not ok_read or #lines == 0 then
    return {}
  end

  local ok_decode, decoded = pcall(vim.fn.json_decode, table.concat(lines, "\n"))
  if not ok_decode or type(decoded) ~= "table" then
    vim.notify("project_frecency: db file was unreadable, starting fresh", vim.log.levels.WARN)
    return {}
  end

  return decoded
end

local function write_db(entries)
  local ok_encode, encoded = pcall(vim.fn.json_encode, entries)
  if not ok_encode then
    vim.notify("project_frecency: failed to encode db: " .. tostring(encoded), vim.log.levels.ERROR)
    return
  end

  local ok_write, err = pcall(vim.fn.writefile, { encoded }, data_path)
  if not ok_write then
    vim.notify("project_frecency: failed to write db: " .. tostring(err), vim.log.levels.ERROR)
  end
end

--- Record one access to `path`. No-ops if this project was already accessed
--- earlier in the current session.
local function record_access(path)
  if seen_this_session[path] then
    return
  end
  seen_this_session[path] = true

  local entries = read_db()

  local found
  for _, e in ipairs(entries) do
    if e.path == path then
      found = e
      break
    end
  end

  local now = os.time()
  if found then
    found.score = found.score + 1
    found.last_accessed = now
  else
    table.insert(entries, { path = path, score = 1, last_accessed = now })
  end

  sort_by_frecency(entries)

  -- Cap at MAX_PROJECTS: sorted highest-frecency first, so anything past
  -- index 12 is the lowest-ranked and gets dropped to make room.
  for i = #entries, MAX_PROJECTS + 1, -1 do
    entries[i] = nil
  end

  write_db(entries)
end

--- Resolve root_dir for a buffer, prompting only if this buffer has already
--- resolved to a *different* root_dir earlier in the session (e.g. two LSP
--- servers on the same buffer disagreeing, common in monorepos).
local function resolve_root_dir(bufnr, client)
  local root_dir = client.config and client.config.root_dir

  if not root_dir then
    root_dir = vim.fs.root(bufnr, { ".git" })
  end

  if not root_dir then
    return nil
  end

  root_dir = vim.fs.normalize(root_dir)

  local previous = buf_root[bufnr]
  if previous == nil or previous == root_dir then
    buf_root[bufnr] = root_dir
    return root_dir
  end

  -- Conflict: ask which one to trust.
  local choice = vim.fn.input(
    string.format("project_frecency: conflicting root_dir for this buffer\n1: %s\n2: %s\nChoose [1/2]: ", previous, root_dir)
  )
  io.write("\n")

  local resolved = (choice == "2") and root_dir or previous
  buf_root[bufnr] = resolved
  return resolved
end

--- Install the LspAttach hook. Call once from your config.
function M.setup()
  vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("project_frecency", { clear = true }),
    callback = function(args)
      local client = vim.lsp.get_client_by_id(args.data.client_id)
      if not client then
        return
      end

      local root_dir = resolve_root_dir(args.buf, client)
      if root_dir then
        record_access(root_dir)
      end
    end,
  })
end

--- Returns up to 12 project entries, sorted by frecency (highest first).
--- Each entry: { path = string, score = number, last_accessed = number }
function M.get_entries()
  local entries = read_db()
  sort_by_frecency(entries)
  return entries
end

--- Convenience: same as get_entries(), but just the paths.
function M.get_projects()
  local paths = {}
  for _, e in ipairs(M.get_entries()) do
    table.insert(paths, e.path)
  end
  return paths
end

--- Path to the underlying JSON db, in case you want to inspect it directly.
M.data_path = data_path

return M
