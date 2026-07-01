---@type vim.lsp.Config
return {
    on_attach = function(client, _) -- Disable formatting capabilities
        client.server_capabilities.documentFormattingProvider = false
    end,
    ---@type lspconfig.settings.pylsp
    settings = {
        pylsp = {
            plugins = {
                mccabe = { threshold = 10 }, -- Code complexity checker

                autopep8 = { enabled = false }, -- Disable formatting in favor of Black
                yapf = { enabled = false }, -- ...

                pyflakes = { enabled = true }, -- Pylint requires the file to be written to disk
                pylint = { enabled = false }, -- and has annoying docstring info diagnostics.

                pycodestyle = { -- Style checker, not formatter.
                    hangClosing = true,
                    maxLineLength = 80,
                    indentSize = 4,
                    ignore = {
                        'E501', -- Line too long
                        'E203', -- Whitespace before ":"
                        'E133', -- Bracket missing indentation
                    },
                },

                jedi_completion = { -- Completion TODO test this
                    include_class_objects = true,
                    include_function_objects = true,
                    fuzzy = true,
                },
            },
            signature = { line_length = 80 },
        },
    },
}
