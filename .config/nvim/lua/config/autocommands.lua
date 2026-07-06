-- Highlight when yanking text.
vim.api.nvim_create_autocmd('TextYankPost', {
    callback = function() vim.hl.on_yank({ timeout = 50 }) end,
})

-- Close some buffers with <q>
vim.api.nvim_create_autocmd('FileType', {
    pattern = { 'help', 'qf' },
    callback = function(event)
        vim.keymap.set(
            'n',
            'q',
            function() vim.cmd('close') end,
            { buffer = event.buf, silent = true }
        )
    end,
})
