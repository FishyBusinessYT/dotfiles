return {
    {
        'mason-org/mason.nvim',
        opts = {
            ui = {
                icons = {
                    package_installed = '✓',
                    package_pending = '➜',
                    package_uninstalled = '✗',
                },
            },
        },
    },
    {
        'mason-org/mason-lspconfig.nvim',
        dependencies = {
            'mason-org/mason.nvim',
            'neovim/nvim-lspconfig',
        },
        ---@module 'mason'
        ---@type MasonSettings
        opts = {
            automatic_enable = true,
            ensure_installed = {
                'lua_ls',
                'stylua',
                'pylsp',
            },
        },
    },
}
