-- Source other config files
require('configs.input')
require('configs.keybinds')
require('configs.lookandfeel')
require('configs.wrules')


-- Monitor config
hl.monitor({ output = '', mode = 'preferred', position = 'auto', scale = '1' })

-- Startup programs
hl.on('hyprland.start', function()
    -- Login screen
    hl.exec_cmd('hyprlock || hyprctl dispatch exit')

    -- Clipboard manager
    hl.exec_cmd('wl-paste --watch cliphist store')

    -- Wallpaper manager
    hl.exec_cmd('awww-daemon --no-cache')
    hl.exec_cmd('~/.config/hypr/scripts/wallpaper_cycle.sh')

    -- Battery level notification
    hl.exec_cmd('~/.config/hypr/scripts/battery_notify.sh')

    -- Polkit authentication daemon
    hl.exec_cmd('systemctl --user start hyprpolkitagent')

    -- Screen blue light filter
    hl.exec_cmd('hyprsunset')

    -- Idle management daemon
    hl.exec_cmd('hypridle')
end)

hl.config({
    misc = {
        --        disable_autoreload = true,
    },
})
