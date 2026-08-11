-- Needs to be loaded after alpha itself.
-- local utils = require('alpha.utils') -- For getting the top level dir for a git repo

local opts = {
    setup = function() -- Function runs once before first draw
        -- Runs if we CD while alpha is running
        vim.api.nvim_create_autocmd('DirChanged', {
            pattern = '*', -- Pattern is irrelevant
            group = 'alpha_temp', -- Augroup is deleted on alpha exit
            callback = function()
                -- utils.git_toplevel_cache = {} -- Needs to be reset when CDing
                require('alpha').redraw() -- Redraw to reflect changes
                vim.cmd('AlphaRemap') -- Remap keys to new options
            end,
        })
    end,
}

local config = {
    layout = {
        { type = 'padding', val = 2 },
        --header,
        { type = 'padding', val = 2 },
        --projects,
        { type = 'padding', val = 2 },
        --buttons,
    },
    opts = opts,
}

return {
    'goolord/alpha-nvim',
    dependencies = {
        'nvim-mini/mini.icons',
        'nvim-lua/plenary.nvim',
    },
    config = function()
        local config = require('alpha.themes.theta').config
        config.opts = opts
        require('alpha').setup(config)
    end,
    --opts = config,
}
