--Highlight when yanking text.
--Try it with `yap` in normal mode. See `:h vim.hl.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
    callback = function() vim.hl.on_yank({ timeout = 50 }) end,
})

--Treesitter highlighting
vim.api.nvim_create_autocmd('FileType', {
    pattern = { 'lua' },
    callback = function()
        vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
    end,
})

--Treesitter highlighting
vim.api.nvim_create_autocmd('FileType', {
    pattern = { 'py' },
    callback = function()
        vim.treesitter.start()
        vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
    end,
})
