-- All keybindings and shortcuts

-- Default programs
local terminal = 'kitty'
local browser = 'firefox'
local fileExplorer = 'ranger'

-- Apps
hl.bind('SUPER + T', hl.dsp.exec_cmd(terminal))
hl.bind('SUPER + F', hl.dsp.exec_cmd(browser))
hl.bind('SUPER + G', hl.dsp.exec_cmd('godot'))
-- hl.bind('SUPER + E', hl.dsp.exec_cmd(fileExplorer))

-- Shutdown, suspend, reboot and lock
hl.bind(
    'SUPER + SHIFT + F4',
    hl.dsp.exec_cmd('systemctl poweroff'),
    { locked = true }
)
hl.bind(
    'SUPER + SHIFT + DELETE',
    hl.dsp.exec_cmd('systemctl reboot'),
    { locked = true }
)
hl.bind(
    'SUPER + SHIFT + ESCAPE',
    hl.dsp.exec_cmd('systemctl suspend'),
    { locked = true }
)
hl.bind('SUPER + SHIFT + L', hl.dsp.exec_cmd('hyprlock'))

-- Take screenshot
hl.bind(
    'SUPER + SHIFT + S',
    hl.dsp.exec_cmd('hyprshot -m region -s --clipboard-only')
)

-- Open color picker
hl.bind('SUPER + SHIFT + P', hl.dsp.exec_cmd('hyprpicker -a -n --format=hex'))

-- Open clipboard history
hl.bind(
    'SUPER + SHIFT + V',
    hl.dsp.exec_cmd(
        'killall clipboard_history.sh || kitty --class clipboard-kitty -e ~/.config/hypr/scripts/clipboard_history.sh'
    )
)

-- Close window
hl.bind('SUPER + Q', hl.dsp.window.kill())

-- Move focus with mainMod + arrow keys
hl.bind('SUPER + H', hl.dsp.focus({ direction = 'l' }))
hl.bind('SUPER + J', hl.dsp.focus({ direction = 'd' }))
hl.bind('SUPER + K', hl.dsp.focus({ direction = 'u' }))
hl.bind('SUPER + L', hl.dsp.focus({ direction = 'r' }))

-- Switch workspaces with mainMod + [1-9]
hl.bind('SUPER + 1', hl.dsp.focus({ workspace = 1 }))
hl.bind('SUPER + 2', hl.dsp.focus({ workspace = 2 }))
hl.bind('SUPER + 3', hl.dsp.focus({ workspace = 3 }))
hl.bind('SUPER + 4', hl.dsp.focus({ workspace = 4 }))
hl.bind('SUPER + 5', hl.dsp.focus({ workspace = 5 }))
hl.bind('SUPER + 6', hl.dsp.focus({ workspace = 6 }))
hl.bind('SUPER + 7', hl.dsp.focus({ workspace = 7 }))
hl.bind('SUPER + 8', hl.dsp.focus({ workspace = 8 }))
hl.bind('SUPER + 9', hl.dsp.focus({ workspace = 9 }))

-- Goto next/previous occupied workspace
hl.bind('SUPER + 0', hl.dsp.focus({ workspace = 'e+1' }))
hl.bind('SUPER + SHIFT + 0', hl.dsp.focus({ workspace = 'e-1' }))

-- Move active window to a workspace with mainMod + SHIFT + [1-5]
hl.bind('SUPER + SHIFT + 1', hl.dsp.window.move({ workspace = 1 })) -- MAY NEED TO ADD, follow=true
hl.bind('SUPER + SHIFT + 2', hl.dsp.window.move({ workspace = 2 })) -- MAY NEED TO ADD, follow=true
hl.bind('SUPER + SHIFT + 3', hl.dsp.window.move({ workspace = 3 })) -- MAY NEED TO ADD, follow=true
hl.bind('SUPER + SHIFT + 4', hl.dsp.window.move({ workspace = 4 })) -- MAY NEED TO ADD, follow=true
hl.bind('SUPER + SHIFT + 5', hl.dsp.window.move({ workspace = 5 })) -- MAY NEED TO ADD, follow=true
hl.bind('SUPER + SHIFT + 6', hl.dsp.window.move({ workspace = 6 })) -- MAY NEED TO ADD, follow=true
hl.bind('SUPER + SHIFT + 7', hl.dsp.window.move({ workspace = 7 })) -- MAY NEED TO ADD, follow=true
hl.bind('SUPER + SHIFT + 8', hl.dsp.window.move({ workspace = 8 })) -- MAY NEED TO ADD, follow=true
hl.bind('SUPER + SHIFT + 9', hl.dsp.window.move({ workspace = 9 })) -- MAY NEED TO ADD, follow=true

-- Multimedia keys for volume and LCD brightness
local mediaControl = '$HOME/.config/hypr/scripts/media_control.sh'
hl.bind(
    'XF86AudioRaiseVolume',
    hl.dsp.exec_cmd(mediaControl .. ' "vol_up"'),
    { locked = true, repeating = true }
)
hl.bind(
    'XF86AudioLowerVolume',
    hl.dsp.exec_cmd(mediaControl .. ' "vol_down"'),
    { locked = true, repeating = true }
)
hl.bind(
    'XF86AudioMute',
    hl.dsp.exec_cmd(mediaControl .. ' "vol_mute"'),
    { locked = true, repeating = true }
)
hl.bind(
    'XF86AudioMicMute',
    hl.dsp.exec_cmd(mediaControl .. ' "mic_mute"'),
    { locked = true, repeating = true }
)
hl.bind(
    'XF86MonBrightnessUp',
    hl.dsp.exec_cmd(mediaControl .. ' "brightness_up"'),
    { locked = true, repeating = true }
)
hl.bind(
    'XF86MonBrightnessDown',
    hl.dsp.exec_cmd(mediaControl .. ' "brightness_down"'),
    { locked = true, repeating = true }
)
