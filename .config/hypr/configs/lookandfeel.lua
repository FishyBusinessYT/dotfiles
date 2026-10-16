-- Aesthetics-related config

-- Cursor
hl.env('XCURSOR_SIZE', 20)

hl.config({
    general = {
        -- Borders and gaps
        border_size = 2,
        gaps_in = 3,
        gaps_out = 3,
        col = {
            active_border = { colors = { '#ffffffff', '#444444ff' } },
        },
    },

    decoration = {
        -- Round corners
        rounding = 5,

        -- Reduce opacity of inactive windows
        inactive_opacity = 0.9,

        -- Disable shadows and blur
        shadow = { enabled = false },
        blur = { enabled = false },
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
hl.curve('eot', { type = 'bezier', points = { { 0, 0.55 }, { 0.45, 1 } } }) -- Fast then slow
hl.curve('lnr', { type = 'bezier', points = { { 0, 0 }, { 1, 1 } } }) -- Linear

-- Global fallback animation (slow to make it obvious when an animation is unset)
hl.animation({ leaf = 'global', enabled = true, speed = 100, bezier = 'lnr' })

-- Layers and popups
hl.animation({
    leaf = 'layers',
    enabled = true,
    speed = 3,
    bezier = 'eot',
    style = 'popin 90%',
})
hl.animation({
    leaf = 'fadeLayers',
    enabled = true,
    speed = 2,
    bezier = 'lnr',
})
hl.animation({
    leaf = 'fadePopups',
    enabled = true,
    speed = 1,
    bezier = 'lnr',
})

-- Windows
hl.animation({
    leaf = 'windows',
    enabled = true,
    speed = 2,
    bezier = 'eot',
    style = 'popin 60%',
})
hl.animation({ leaf = 'fadeIn', enabled = true, speed = 2, bezier = 'lnr' })
hl.animation({ leaf = 'fadeOut', enabled = true, speed = 2, bezier = 'lnr' })
hl.animation({ leaf = 'fadeDim', enabled = false }) -- There's no dimming
hl.animation({ leaf = 'fadeShadow', enabled = false }) -- Shadows are disabled
hl.animation({
    leaf = 'fadeSwitch',
    enabled = true,
    speed = 5,
    bezier = 'lnr',
})

-- Borders
hl.animation({ leaf = 'border', enabled = true, speed = 2, bezier = 'lnr' })
hl.animation({
    leaf = 'borderangle',
    enabled = true,
    speed = 30,
    bezier = 'lnr',
})

-- Switching workspaces
hl.animation({
    leaf = 'workspaces',
    enabled = true,
    speed = 1.5,
    bezier = 'eot',
    style = 'slide',
})

-- Disable startup zoom
hl.animation({ leaf = 'monitorAdded', enabled = false })
