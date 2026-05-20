-- Window rules

-- Ignore maximize requests
hl.window_rule({
    name = 'ignore-maximize',
    match = { class = '.*' },
    suppress_event = 'maximize',
})

-- No gaps when only
hl.workspace_rule({ workspace = 'w[tv1]', gaps_in = 0, gaps_out = 0 })
hl.window_rule({
    match = { float = false, workspace = 'w[tv1]' },
    rounding = 0,
    border_size = 0,
})
hl.window_rule({
    match = { float = false, workspace = 'f[1]' },
    rounding = 0,
    border_size = 0,
})

-- Float file picker windows
hl.window_rule({
    match = { class = 'xdg-desktop-portal-gtk' },
    float = true,
    size = { 1000, 700 },
    decorate = false,
})

-- Clipboard history window rules
hl.window_rule({
    match = { class = 'clipboard-kitty' },
    float = true,
    size = { 800, 600 },
})

-- Fix an issue with Hyprshot including the selection border in screenshots
hl.layer_rule({ match = { namespace = 'selection' }, no_anim = true })
