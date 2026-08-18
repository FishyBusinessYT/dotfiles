-- Set up project tracking autocommand
require('plugins.ui.alpha.project-list').setup()

local buttons = require('plugins.ui.alpha.buttons').buttons
local projects = require('plugins.ui.alpha.projects').projects

local header = {
    type = 'text',
    val = {
        [[                                                               ]],
        [[  |\_/|                                                        ]],
        [[ _|O.OL_        __                               (\_/)      ___]],
        [[ \ U U  \___  _|__| _____   __  _  _____________  X.O /  __| _/]],
        [[ /       \  \/ /  |/     \  \ \/ \/ /    \_  __ \ U U/  / __ | ]],
        [[/    |    \   /|  |  Y Y  \  \     (  <>  )  | \/ |  L_/ /_/ | ]],
        [[\____|__  /\_/ |__|__|_|  /   \/\_/ \____/|__|   /v_v_/\____ | ]],
        [[        \/              \/                                  \/ ]],
    },
    opts = {
        position = 'center',
        hl = 'AlphaHeader',
    },
}

local opts = {
    -- margin = 5, -- Not really relevant when everything is centered.
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
        { type = 'padding', val = 8 },
        header,
        { type = 'padding', val = 2 },
        buttons,
        { type = 'padding', val = 2 },
        projects,
    },
    opts = opts,
}

return {
    'goolord/alpha-nvim',
    dependencies = {
        'nvim-mini/mini.icons',
        'nvim-lua/plenary.nvim',
    },
    config = function() -- Alpha modules can only be imported here:
        require('alpha').setup(config)
    end,
    --opts = config,
}
