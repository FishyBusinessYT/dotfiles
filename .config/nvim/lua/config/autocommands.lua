-- Highlight when yanking text.
vim.api.nvim_create_autocmd('TextYankPost', {
    callback = function() vim.hl.on_yank({ timeout = 50 }) end,
})

-- Use Treesitter highlighting
vim.api.nvim_create_autocmd('FileType', {
    pattern = { 'lua', 'python', 'rust' },
    callback = function()
        vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
    end,
})

-- Close help pages with <q>
vim.api.nvim_create_autocmd('FileType', {
    pattern = { 'help' },
    callback = function(event)
        vim.keymap.set(
            'n',
            'q',
            function() vim.cmd('close') end,
            { buffer = event.buf, silent = true }
        )
    end,
})
