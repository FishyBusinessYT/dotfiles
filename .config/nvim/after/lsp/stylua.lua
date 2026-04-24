local defaultConfig = [[
syntax = 'LuaJIT'
column_width = 80
indent_type = 'Spaces'
indent_width = 4
quote_style = 'ForceSingle'
collapse_simple_statement = 'Always'
]]

---@type vim.lsp.Config
return {
    root_markers = { '.stylua.toml', '.git' },
    on_init = function(client)
        if client.workspace_folders then
            local filepath = client.workspace_folders[1].name .. '/.stylua.toml'
            if vim.uv.fs_stat(filepath) then return end

            local f = io.open(filepath, 'w')
            if f == nil then return end

            f:write(defaultConfig)
            f:close()
        end
    end,
}
