return {
    'nvim-neo-tree/neo-tree.nvim',
    branch = 'v3.x',
    dependencies = {
        'nvim-lua/plenary.nvim',
        'MunifTanjim/nui.nvim',
        'nvim-tree/nvim-web-devicons',
    },
    lazy = false,
    opts = {
        sort_case_insensitive = true,
        default_component_configs = {
            indent = { padding = 0 },
            modified = { symbol = '*' },
            name = { highlight_opened_files = true },
        },
        filesystem = {
            filtered_items = { visible = true },
            follow_current_file = { enabled = true },
            use_libuv_file_watcher = true,
        },
        buffers = {
            show_unloaded = true,
            terminals_first = true,
        },
        event_handlers = {
            {
                event = 'neo_tree_buffer_leave',
                handler = function()
                    local shown_buffers = {}
                    for _, win in ipairs(vim.api.nvim_list_wins()) do
                        shown_buffers[vim.api.nvim_win_get_buf(win)] = true
                    end
                    for _, buf in ipairs(vim.api.nvim_list_bufs()) do
                        if
                            not shown_buffers[buf]
                            and vim.api.nvim_get_option_value('buftype', {buf=buf}) == 'nofile'
                            and vim.api.nvim_get_option_value('filetype', {buf=buf}) == 'neo-tree'
                        then
                            vim.api.nvim_buf_delete(buf, {})
                        end
                    end
                end,
            },
        },
    },
}
