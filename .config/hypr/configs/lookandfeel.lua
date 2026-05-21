-- Aesthetics-related config

-- Cursor
hl.env('XCURSOR_SIZE', 20)

hl.config({
    general = {
        -- Borders and gaps
        border_size = 3,
        gaps_in = 10,
        gaps_out = 25,
        col = {
            active_border = { colors = { '#ffffffff', '#444444ff' } },
        },
    },

    decoration = {
        -- Round corners
        rounding = 10,

        -- Dim and reduce opacity of inactive windows
        inactive_opacity = 0.9,
        dim_inactive = true,
        dim_strength = 0.2,

        -- Disable shadows
        shadow = { enabled = false },
    },

    misc = {
        -- Disable splash text and hyprland logo
        disable_hyprland_logo = true,
        disable_splash_rendering = true,

        -- Enable window swallowing
        enable_swallow = true,
        swallow_regex = 'kitty',
    },
})

-- Animations

-- Defining curves
hl.curve('easeout', { type = 'bezier', points = { { 0, 0.55 }, { 0.45, 1 } } }) -- Fast then slow
hl.curve('linear', { type = 'bezier', points = { { 0, 0 }, { 1, 1 } } }) -- Linear
hl.curve('snap', { type = 'bezier', points = { { 1, 0.1 }, { 0, 0.9 } } }) -- Snappy

-- Global fallback animation (slow to make it obvious when an animation is unset)
hl.animation({ leaf = 'global', enabled = true, speed = 100, bezier = 'linear' })

-- Layers and popups
hl.animation({
    leaf = 'layers',
    enabled = true,
    speed = 3,
    bezier = 'easeout',
    style = 'popin 90%',
})
hl.animation({
    leaf = 'fadeLayers',
    enabled = true,
    speed = 2,
    bezier = 'linear',
})
hl.animation({
    leaf = 'fadePopups',
    enabled = true,
    speed = 1,
    bezier = 'linear',
})

-- Windows
hl.animation({
    leaf = 'windows',
    enabled = true,
    speed = 3,
    bezier = 'easeout',
    style = 'popin 60%',
})
hl.animation({ leaf = 'fadeIn', enabled = true, speed = 2, bezier = 'linear' })
hl.animation({ leaf = 'fadeOut', enabled = true, speed = 2, bezier = 'linear' })
hl.animation({ leaf = 'fadeDim', enabled = true, speed = 5, bezier = 'easeout' })
hl.animation({
    leaf = 'fadeSwitch',
    enabled = true,
    speed = 5,
    bezier = 'easeout',
})
hl.animation({
    leaf = 'fadeShadow',
    enabled = true,
    speed = 5,
    bezier = 'easeout',
})

-- Borders
hl.animation({ leaf = 'border', enabled = true, speed = 2, bezier = 'linear' })
hl.animation({
    leaf = 'borderangle',
    enabled = true,
    speed = 30,
    bezier = 'linear',
})

-- Switching workspaces
hl.animation({
    leaf = 'workspaces',
    enabled = true,
    speed = 2,
    bezier = 'easeout',
    style = 'slide',
})

-- Disable startup zoom
hl.animation({ leaf = 'monitorAdded', enabled = false })
