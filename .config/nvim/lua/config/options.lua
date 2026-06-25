local opt = vim.opt

--  VISUAL
opt.wrap = false -- Disable line wrapping
opt.colorcolumn = '80,120' -- Mark columns 80 and 120 to help limit the length of single lines of code
opt.number = true -- Show current line number
opt.relativenumber = true -- Show relative numbers for easy jumps
opt.cursorline = true -- Highlight the line where the cursor's located
opt.scrolloff = 10 -- Keep a margin of 10 lines visible around the cursor when possible
opt.sidescrolloff = 10 -- ...
-- opt.scrolloffpad = 1 -- ... (Enable on next update)
opt.list = true -- Display whitespace characters and trailing spaces
opt.signcolumn = 'yes' -- Reserve a column for error icons and such
opt.foldcolumn = 'auto' -- Amount of columns to reserve for folds
opt.foldtext = '' -- Display the line's normal text when folded
opt.fillchars = { -- Remove ugly dashes from folds
    foldopen = '',
    foldclose = '',
}

-- INDENTATION
opt.shiftwidth = 4 -- Set indent size to 4
opt.expandtab = true -- Use spaces instead of tabs
opt.shiftround = true -- Snap < and > commands' indent to multiples of 4.

-- SEARCH
opt.ignorecase = true -- Ignore case for searching unless the search contains uppercase characters
opt.smartcase = true -- ...

-- BEHAVIOR
opt.clipboard = 'unnamedplus' -- Sync Neovim and system clipboard
opt.completeopt:append('noinsert') -- Don't automatically insert text when opening the completion menu
opt.confirm = true -- Ask to save changes before closing buffer instead of failing
opt.undofile = true -- Save undo history to persist between sessions
opt.updatetime = 1000 -- Time between writes to the backup file in case nvim crashes
opt.mouse = '' -- Disable mouse
opt.gdefault = true -- Replace all occurrences in file by default when using the ':s' command
opt.foldlevelstart = 99 -- Keep all folds open on file load


-- COMPLETION



vim.bo.indentexpr = 'v:lua.require("nvim-treesitter").indentexpr()' -- Treesitter indents
vim.wo.foldmethod = 'expr' -- Use an expression for folds (useful for treesitter)
