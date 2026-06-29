local opt = vim.opt

-- VISUAL
opt.number = true -- Show current line number
opt.relativenumber = true -- Show relative numbers for easy jumps
opt.cursorline = true -- Highlight the line where the cursor's located
opt.wrap = false -- Disable line wrapping
opt.colorcolumn = '80,120' -- Mark columns 80 and 120 to help limit the length of single lines of code
opt.list = true -- Display whitespace characters and trailing spaces
opt.signcolumn = 'yes' -- Reserve a column for error icons and such
opt.laststatus = 3 -- Have status line go across the whole window
opt.scrolloff = 10 -- Keep a margin of 10 lines visible around the cursor when possible
opt.sidescrolloff = 10 -- ...
-- opt.scrolloffpad = 1 -- ... (Enable on next update)

-- INDENTATION
opt.shiftwidth = 4 -- Set indent size to 4
opt.expandtab = true -- Use spaces instead of tabs
opt.shiftround = true -- Snap < and > commands' indent to multiples of 4.

-- SEARCH
opt.ignorecase = true -- Ignore case for searching unless the search contains uppercase characters
opt.smartcase = true -- ...
opt.incsearch = true -- Show matches while typing
opt.gdefault = true -- Replace all occurrences in file by default when using the ':s' command

-- FILES
opt.undofile = true -- Save undo history to persist between sessions
opt.updatetime = 1000 -- Time between writes to the backup file in case nvim crashes
opt.confirm = true -- Ask to save changes before closing buffer instead of failing

-- BEHAVIOR
opt.completeopt = 'menu,popup,noinsert' -- Don't automatically insert text when opening the completion menu
opt.iskeyword = '@,48-57,_,192-255,-' -- Treat dash as part of the word
opt.clipboard = 'unnamedplus' -- Sync Neovim and system clipboard
opt.mouse = '' -- Disable mouse
opt.virtualedit = 'block' -- Allow cursor to move over empty space in visual block mode
opt.timeoutlen = 200 -- How much to wait for a key sequence to complete

-- FOLDS
vim.wo.foldmethod = 'expr' -- Use a custom expression for folds (see UFO plugin)
opt.foldlevelstart = 99 -- Keep all folds open on file load
opt.foldcolumn = 'auto' -- Amount of columns to reserve for folds
opt.foldtext = '' -- Display the line's normal text when folded
opt.fillchars = { -- Remove ugly dashes from folds
    foldopen = '',
    foldclose = '',
}

-- SPLITS
opt.splitbelow = true -- Horizontally split windows go down
opt.splitright = true -- Vertically split windows go right

-- TODO COMPLETION
