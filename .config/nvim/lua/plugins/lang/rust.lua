local function set_keymaps(_, bufnr)
    vim.keymap.set(
        'n',
        '<leader>R',
        function() vim.cmd.RustLsp('codeAction') end,
        { desc = 'Rust Code Action', buffer = bufnr }
    )
    vim.keymap.set(
        'n',
        '<leader>dr',
        function() vim.cmd.RustLsp('debuggables') end,
        { desc = 'Rust Debuggables', buffer = bufnr }
    )
end

local lsp_settings = {
    ---@type lspconfig.settings.rust_analyzer
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
}

return {
    {
        'saecki/crates.nvim',
        event = { 'BufRead Cargo.toml' },
        opts = { -- Taken from LazyVim
            completion = {
                crates = {
                    enabled = true,
                },
            },
            lsp = {
                enabled = true,
                actions = true,
                completion = true,
                hover = true,
            },
        },
    },
    {
        'mrcjkb/rustaceanvim',
        ft = { 'rust' },
        opts = {
            server = {
                on_attach = set_keymaps,
                default_settings = lsp_settings,
            },
        },
        config = function(_, opts)
            -- Rustaceanvim uses this method of configuring instead of setup()
            vim.g.rustaceanvim = vim.tbl_deep_extend(
                'keep',
                vim.g.rustaceanvim or {},
                opts or {}
            )
        end,
    },
}
