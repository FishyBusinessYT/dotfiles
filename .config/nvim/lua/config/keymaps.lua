-- Leader key for custom mappings
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

--Press <Esc> to
vim.keymap.set('t', '<Esc>', '<C-\\><C-n>', { desc = 'Go back to normal mode' })

-- Move between windows with <Alt> + <hjkl>
vim.keymap.set(
    { 't', 'i', 'n' },
    '<A-h>',
    '<C-\\><C-n><C-w>h',
    { desc = 'Move cursor to left window' }
)
vim.keymap.set(
    { 't', 'i', 'n' },
    '<A-j>',
    '<C-\\><C-n><C-w>j',
    { desc = 'Move cursor to lower window' }
)
vim.keymap.set(
    { 't', 'i', 'n' },
    '<A-k>',
    '<C-\\><C-n><C-w>k',
    { desc = 'Move cursor to upper window' }
)
vim.keymap.set(
    { 't', 'i', 'n' },
    '<A-l>',
    '<C-\\><C-n><C-w>l',
    { desc = 'Move cursor to right window' }
)

-- Clear search highlights with <Esc> when in normal mode
vim.keymap.set(
    'n',
    '<Esc>',
    '<cmd>nohlsearch<CR>',
    { desc = 'Clear search highlights' }
)

-- Open and close NeoTree <Leader> + n
vim.keymap.set('n', '<leader>n', '<cmd>Neotree toggle<CR>')

-- Open NeoTree buffers view with <Leader> + b
vim.keymap.set('n', '<leader>b', '<cmd>Neotree toggle buffers<CR>')

-- Go to definition with <Leader> + d
vim.keymap.set(
    'n',
    '<leader>d',
    vim.lsp.buf.definition,
    { desc = 'Go to definition' }
)

-- Open diagnostics hover with <Leader> + D
vim.keymap.set(
    'n',
    '<leader>D',
    vim.diagnostic.open_float,
    { desc = 'Open hover' }
)

-- Go to implementation (function definition) with <Leader>+i
vim.keymap.set(
    'n',
    '<leader>i',
    vim.lsp.buf.implementation,
    { desc = 'Go to implementation' }
)

-- Rename symbol with <Leader>r
vim.keymap.set('n', '<leader>r', vim.lsp.buf.rename, { desc = 'Rename' })

-- Open code actions with <Leader>a
vim.keymap.set(
    'n',
    '<leader>a',
    vim.lsp.buf.code_action,
    { desc = 'Code actions' }
)

-- Format buffer with <Leader>f
vim.keymap.set(
    'n',
    '<leader>f',
    vim.lsp.buf.format,
    { desc = 'Format document' }
)

-- Open hover with K
vim.keymap.set('n', 'K', vim.lsp.buf.hover, { desc = 'Open hover menu' })
