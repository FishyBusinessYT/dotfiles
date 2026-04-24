--Leader key for custom mappings
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

--Press <Esc> to go back to normal mode in terminal windows
vim.keymap.set('t', '<Esc>', '<C-\\><C-n>')

--Move between windows with <Alt> + <hjkl>
vim.keymap.set({ 't', 'i', 'n' }, '<A-h>', '<C-\\><C-n><C-w>h')
vim.keymap.set({ 't', 'i', 'n' }, '<A-j>', '<C-\\><C-n><C-w>j')
vim.keymap.set({ 't', 'i', 'n' }, '<A-k>', '<C-\\><C-n><C-w>k')
vim.keymap.set({ 't', 'i', 'n' }, '<A-l>', '<C-\\><C-n><C-w>l')

--Clear search highlights with <Esc> when in normal mode
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

--Open and close NeoTree <Leader> + n
vim.keymap.set('n', '<leader>n', '<cmd>Neotree toggle<CR>')

--Open NeoTree buffers view with <Leader> + b
vim.keymap.set('n', '<leader>b', '<cmd>Neotree toggle buffers<CR>')

--Go to definition with <Leader> + d
vim.keymap.set('n', '<leader>d', vim.lsp.buf.definition)

--Open diagnostics hover with <Leader> + D
vim.keymap.set('n', '<leader>D', vim.diagnostic.open_float)

--Go to implementation (function definition) with <Leader>+i
vim.keymap.set('n', '<leader>i', vim.lsp.buf.implementation)

--Rename symbol with <Leader>r
vim.keymap.set('n', '<leader>r', vim.lsp.buf.rename)

--Open code actions with <Leader>ca
vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action)

--Format buffer with <Leader>f
vim.keymap.set('n', '<leader>f', vim.lsp.buf.format)

--Open hover with K
vim.keymap.set('n', 'K', vim.lsp.buf.hover)
