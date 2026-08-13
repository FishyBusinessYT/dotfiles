-- Needs to be loaded after alpha itself.
-- local utils = require('alpha.utils') -- For getting the top level dir for a git repo
local function make_button(shortcut, txt, callback)
    local opts = { -- Button display options
        position = 'center',
        shortcut = shortcut,
        cursor = -2,
        width = 35,
        align_shortcut = 'right',
        hl = 'AlphaButtons',
        hl_shortcut = 'AlphaShortcut',
    }

    -- Remove whitespace
    shortcut = shortcut:gsub('%s', '')
    if callback then
        opts.keymap = { -- This is forwarded to vim.keymap.set by alpha
            'n',
            shortcut,
            callback,
            { noremap = true, silent = true, nowait = true },
        }
    end

    local on_press
    if type(callback) == 'function' then
        on_press = callback
    else
        on_press = function()
            local key =
                vim.api.nvim_replace_termcodes(callback, true, false, true)
            vim.api.nvim_feedkeys(key, 't', false)
        end
    end

    return {
        type = 'button',
        val = txt,
        on_press = on_press,
        opts = opts,
    }
end

local header = {
    type = 'text',
    val = {
        [[ _______        __                  (\_/)        __        ___]],
        [[ \      \___  _|__| _____   __  _  _|O.OL_______|  |    __| _/]],
        [[ /   |   \  \/ /  |/     \  \ \/ \/ /U U \_  __ \  |   / __ | ]],
        [[/    |    \   /|  |  Y Y  \  \     (  ==  )  | \/  |__/ /_/ | ]],
        [[\____|__  /\_/ |__|__|_|  /   \/\_/ \____/|__|  |____/\____ | ]],
        [[        \/              \/                                 \/ ]],
    },
    opts = {
        position = 'center',
        hl = 'AlphaHeader',
    },
}

local buttons = {
    type = 'group',
    val = {
        {
            type = 'text',
            val = 'Quick links',
            opts = { hl = 'SpecialComment', position = 'center' },
        },
        { type = 'padding', val = 1 },
        make_button('e', '  New file', '<cmd>ene<CR>'),
        make_button('<leader> f f', '󰈞  Find file'),
        make_button('<leader> f g', '󰊄  Live grep'),
        make_button('ñ', 'NUKLLEAR', function() vim.print('BOOM') end),
        make_button(
            'c',
            '  Configuration',
            '<cmd>exe \'cd\' stdpath (\'config\')<CR>'
        ),
        make_button('u', '  Update plugins', '<cmd>Lazy sync<CR>'),
        make_button('q', '󰅚  Quit', '<cmd>qa<CR>'),
    },
    opts = {
        spacing = 1, -- Test this and remove if unnecessary
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
        --projects,
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
