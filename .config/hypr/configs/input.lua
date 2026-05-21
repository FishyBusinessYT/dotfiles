-- All input-related config (keyboard, touchpad, gestures, etc.) with the exception of keybinds

hl.config({
    input = {
        kb_layout = 'us',
        kb_variant = 'altgr-intl',

        -- Hold-down repeating input
        repeat_rate = 30,
        repeat_delay = 300,

        -- Click windows to focus
        follow_mouse = 2,

        -- Invert touchpad scroll
        touchpad = {
            natural_scroll = true,
        },
    },
    gestures = {
        -- Swipe feeling tweaks
        workspace_swipe_distance = 2000,
        workspace_swipe_min_speed_to_force = 10,
        workspace_swipe_direction_lock = false,
    },
    cursor = {
        -- Hide the cursor after some time
        inactive_timeout = 3,

        -- Don't teleport the cursor when changing focus with the keyboard
        no_warps = true,

        -- Self explanatory
        hide_on_key_press = true,
    },
    misc = {
        middle_click_paste = false,
    },
})

-- Swipe touchpad with three fingers to change workspaces
hl.gesture({
    fingers = 3,
    direction = 'horizontal',
    action = 'workspace',
})

-- Pinch to zoom
hl.gesture({
    fingers = 2,
    direction = 'pinch',
    action = 'cursor_zoom',
})
