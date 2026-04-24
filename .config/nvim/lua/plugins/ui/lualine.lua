return {
    'nvim-lualine/lualine.nvim',
    dependencies = {
        'nvim-tree/nvim-web-devicons',
        'justinhj/battery.nvim',
    },
    opts = {
        theme = 'auto',
        inactive_sections = {},
        sections = {
            lualine_a = {
                { 'mode', fmt = function(str) return str:sub(1, 1) end },
            },
            lualine_b = {
                {
                    'buffers',
                    hide_filename_extension = true,
                    symbols = { modified = ' *' },
                },
            },
            lualine_c = { 'branch', 'diagnostics' },
            lualine_x = { 'searchcount', 'selectioncount', 'location' },
            lualine_y = { 'lsp_status' },
            lualine_z = {
                { 'filetype', separator = '' },
                {
                    require('battery').get_status_line,
                    fmt = function(str) return str:sub(5) end,
                },
            },
        },
    },
}
