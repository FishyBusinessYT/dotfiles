return {
    'saghen/blink.cmp',
    version = '1.*',
    -- optional: provides snippets for the snippet source
    dependencies = { 'rafamadriz/friendly-snippets' },

    ---@type blink.cmp.Config
    opts = {
        keymap = {
            preset = 'default',
            ['<Tab>'] = { 'accept', 'fallback' },
        },

        completion = {
            keyword = { range = 'full' },
            trigger = { show_on_insert = true }, -- Auto show
            list = { selection = { auto_insert = false } },
            menu = { draw = { snippet_indicator = ' >>' } },
            ghost_text = { enabled = true },

            documentation = {
                auto_show = true,
                auto_show_delay_ms = 10,
            },
        },

        signature = { enabled = true },
        fuzzy = { implementation = 'rust' },
        cmdline = { completion = { menu = { auto_show = true } } },
    },
}
