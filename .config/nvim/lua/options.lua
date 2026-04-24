--Don't silently reload files
vim.opt.autoread = false

--Don't break in the middle of words
vim.opt.linebreak = true

--Keep indentation when wrapping
vim.opt.breakindent = true

--For visually separating wrapped lines
vim.opt.showbreak = '↪ '

--Sync Neovim and system clipboard
vim.opt.clipboard = 'unnamedplus'

--Mark column 80 to help limit the length of single lines of code
vim.opt.colorcolumn = '80,120'

--Don't automatically insert text when opening the completion menu
vim.opt.completeopt:append('noinsert')

--Ask to save changes before closing buffer instead of failing
vim.opt.confirm = true

--Show current line number
vim.opt.number = true

--Show relative numbers for easy jumps
vim.opt.relativenumber = true

--Highlight the line where the cursor's located
vim.opt.cursorline = true

--Keep a margin of 10 lines visible around the cursor when possible
vim.opt.scrolloff = 10

--Set indent size to 4 and use spaces for tabs
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

--Snap 'tab's to multiples of 4.
vim.opt.shiftround = true

--Ignore case for searching unless the search contains uppercase characters
vim.opt.ignorecase = true
vim.opt.smartcase = true

--Display trailing spaces
vim.opt.list = true

--Save undo history to persist between sessions
vim.opt.undofile = true

--Reserve a column for error icons and such
vim.opt.signcolumn = 'yes'

--Time between writes to the backup file in case nvim crashes
vim.opt.updatetime = 1000

--Disable mouse
vim.opt.mouse = ''

--Treesitter indents
vim.bo.indentexpr = 'v:lua.require("nvim-treesitter").indentexpr()'

--Replace all occurrences in file by default when using the ':s' command
vim.opt.gdefault = true

--Unload abandoned buffers
vim.opt.hidden = false

--Use an expression for folds (useful for treesitter)
vim.wo.foldmethod = 'expr'

--Remove ugly dashes from folds
vim.opt.fillchars = {
    foldopen = '',
    foldclose = '',
}
vim.opt.foldlevelstart = 99
vim.opt.foldcolumn = 'auto'
vim.opt.foldtext = ''
