local M = {}

M.make_button = function(shortcut, txt, callback)
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
            local keys =
                vim.api.nvim_replace_termcodes(callback, true, false, true)
            vim.api.nvim_feedkeys(keys, 't', false)
        end
    end

    return {
        type = 'button',
        val = txt,
        on_press = on_press,
        opts = opts,
    }
end

M.buttons = {
    type = 'group',
    val = {
        {
            type = 'text',
            val = 'Quick Menu',
            opts = { hl = 'WarningMsg', position = 'center' },
        },
        { type = 'padding', val = 0 }, -- 2 spaces are still inserted, see 'spacing' below
        M.make_button('e', '  New file', '<cmd>enew<CR>'),
        M.make_button(
            'c',
            '  Configuration',
            '<cmd>exe \'cd\' stdpath (\'config\')<CR>'
        ),
        M.make_button('u', '  Update plugins', '<cmd>Lazy sync<CR>'),
        M.make_button('q', '󰅚  Quit', '<cmd>qa<CR>'),
    },
    opts = { spacing = 1 },
}

return M
