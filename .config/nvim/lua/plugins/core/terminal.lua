vim.keymap.set({ 'i', 'n', 't' }, '<S-D-F23>', '<Esc><Cmd>ToggleTerm<CR>', {
    silent = true,
    desc = 'Toggle terminal',
})

return {
    'akinsho/toggleterm.nvim',
    opts = {
        start_in_insert = true,
        persist_size = false,
        persist_mode = false,

        direction = 'float',
        float_opts = {
            border = 'curved',
            width = math.floor(vim.o.columns * 0.65),
            height = math.floor(vim.o.lines * 0.80),
            winblend = 20,
        },
    },
}
