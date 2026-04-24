local function overrideForNvim(client)
    --If working on nvim's default config folder,
    if client.workspace_folders then
        local path = client.workspace_folders[1].name
        if path ~= vim.fn.stdpath('config') then return end
    end

    --Get Neovim's runtime files
    local runtime_files = vim.api.nvim_get_runtime_file('', true)

    for k, v in ipairs(runtime_files) do
        if
            v == vim.fn.stdpath('config')
            or v == vim.fn.stdpath('config') .. '/after'
        then
            table.remove(runtime_files, k)
        end
    end

    --And override some of the LSPs config values
    client.config.settings.Lua =
        vim.tbl_deep_extend('force', client.config.settings.Lua, {
            runtime = {
                version = 'LuaJIT',
                path = { 'lua/?.lua', 'lua/?/init.lua' },
            },
            workspace = { library = runtime_files },
        })
end

---@type vim.lsp.Config
return {
    on_init = overrideForNvim,
    settings = {
        Lua = { --TEST completion, completion.autorequire, completion.keywordSnippet
            format = { enable = false },
            hover = { expandAlias = false },
            workspace = { checkThirdParty = 'Disable' },
            runtime = { version = 'Lua 5.4' },
            semantic = { keyword = true }
        },
    },
}
