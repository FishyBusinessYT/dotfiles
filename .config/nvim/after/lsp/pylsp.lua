---@type vim.lsp.Config
return {
    settings = {
        pylsp = {
            plugins = {
                mccabe = { enabled = false },
                preload = { enabled = false },
                pycodestyle = {
                    hangClosing = true,
                    maxLineLength = 80,
                    indentSize = 4,
                },
            },
            signature = { line_length = 80 },
        },
    },
}
