vim.keymap.set({ 'i', 'n', 't' }, '<S-D-F23>', '<Esc><Cmd>ToggleTerm<CR>', {
    silent = true,
    desc = 'Toggle terminal',
})
vim.keymap.set({ 'i', 'n', 't' }, '<M-S-D-F23>', '<Esc><Cmd>TermNew<CR>', {
    silent = true,
    desc = 'Open new terminal',
})

return {
    'akinsho/toggleterm.nvim',
    opts = {
        size = 55,
        shading_factor = -20,
        start_in_insert = true,
        persist_size = false,
        persist_mode = false,
        direction = 'vertical'
    },
}
