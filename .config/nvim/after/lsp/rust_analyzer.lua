---@type vim.lsp.Config
return {
    ---@type lspconfig.settings.rust_analyzer
    settings = {
        -- rust-analyzer language server configuration
        ['rust-analyzer'] = {
            cargo = {
                features = { 'all' },
                buildScripts = { enable = true },
            },
            checkOnSave = true, -- Add clippy lints for Rust
            diagnostics = { enable = true }, -- Enable diagnostics
            procMacro = { enable = true }, -- Procedural Macro support
            files = {
                exclude = {
                    '.direnv',
                    '.git',
                    '.jj',
                    '.github',
                    '.gitlab',
                    'bin',
                    'node_modules',
                    'target',
                    'venv',
                    '.venv',
                },
            },
        },
    },
}
