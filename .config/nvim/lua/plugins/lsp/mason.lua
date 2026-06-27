---@module 'mason'
---@type MasonSettings
local mason_opts = {
    firewall = {
        enabled = true
    },
    ui = {
        icons = {
            package_installed = '✓',
            package_pending = '➜',
            package_uninstalled = '✗',
        },
    },
}

---@module 'mason-lspconfig'
---@type MasonLspconfigSettings
local mason_lspcfg_opts = {
    automatic_enable = true,
    ensure_installed = {
        'lua_ls',
        'stylua',
        'pylsp',
    },
}

return {
    {
        'mason-org/mason-lspconfig.nvim',
        dependencies = {
            { 'mason-org/mason.nvim', opts = mason_opts },
            'neovim/nvim-lspconfig',
        },
        opts = mason_lspcfg_opts,
    },
}
