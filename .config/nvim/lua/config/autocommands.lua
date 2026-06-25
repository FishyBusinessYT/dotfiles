--Highlight when yanking text.
--Try it with `yap` in normal mode. See `:h vim.hl.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
    callback = function() vim.hl.on_yank({ timeout = 50 }) end,
})
