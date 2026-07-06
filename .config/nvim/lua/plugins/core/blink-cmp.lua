return {
    'saghen/blink.cmp',
    version = '1.*',
    -- optional: provides snippets for the snippet source
    dependencies = { 'rafamadriz/friendly-snippets' },

    ---@type blink.cmp.Config
    opts = {
        keymap = {
            preset = 'default',
            ['<Tab>'] = { 'select_next', 'snippet_forward', 'fallback' },
            ['<S-Tab>'] = { 'select_prev', 'snippet_backward', 'fallback' },
        },

        completion = {
            keyword = { range = 'full' },
            trigger = { show_on_insert = true }, -- Auto show
            list = { selection = { preselect = false, auto_insert = true } },
            menu = { draw = { snippet_indicator = ' >>' } },
            ghost_text = { enabled = true },

            documentation = {
                auto_show = true,
                auto_show_delay_ms = 10,
            },
        },

        signature = { enabled = true },
        fuzzy = { implementation = 'rust' },
        cmdline = {
            completion = {
                list = { selection = { preselect = false, auto_insert = true } },
                menu = { auto_show = true },
            },
        },
    },
}
