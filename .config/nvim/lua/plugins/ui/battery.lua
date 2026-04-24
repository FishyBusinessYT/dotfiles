return {
    'justinhj/battery.nvim',
    dependencies = {
        'nvim-tree/nvim-web-devicons',
        'nvim-lua/plenary.nvim',
    },
    opts = {
        update_rate_seconds = 60,
        vertical_icons = false,
        show_unplugged_icon = false,
        show_plugged_icon = false,
        show_percent = true,
    },
}
