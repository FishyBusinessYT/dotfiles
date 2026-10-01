---@type LazyPluginSpec
return {
    'folke/which-key.nvim',
    event = 'VeryLazy',
    keys = {
        {
            '<leader>?',
            function() require('which-key').show({ global = true }) end,
            desc = 'Show keymaps',
        },
    },
    ---@type wk.Opts
    opts = {
        preset = 'modern',
        plugins = { spelling = { enabled = false } },
        ---@type wk.Win.opts
        win = {
            width = 120,
            padding = { 0, 0 },
        },
    },
}
