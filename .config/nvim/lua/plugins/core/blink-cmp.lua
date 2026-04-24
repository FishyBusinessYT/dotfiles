return {
    'saghen/blink.cmp',
    version = '1.*',
    -- optional: provides snippets for the snippet source
    --dependencies = { 'rafamadriz/friendly-snippets' },

    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
        keymap = {
            preset = 'super-tab',
        },
        completion = {
            keyword = { range = 'full' },
            trigger = { show_in_snippet = false },
            list = { selection = { auto_insert = false } },
            menu = { draw = { snippet_indicator = '' } },
            documentation = {
                auto_show = true,
                auto_show_delay_ms = 100,
            },
            ghost_text = {
                enabled = true,
                show_without_selection = true,
                show_without_menu = false,
            },
        },
        signature = { enabled = true },
        fuzzy = { implementation = 'rust' },
    },
}
