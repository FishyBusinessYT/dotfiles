---@type LazyPluginSpec
return {
    'folke/which-key.nvim',
    event = 'VeryLazy',
    keys = {
        {
            '<F9>',
            function() require('which-key').show({ global = true }) end,
            desc = 'Buffer Local Keymaps (which-key)',
        },
    },
}
