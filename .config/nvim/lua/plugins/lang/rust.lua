return {
    'saecki/crates.nvim',
    event = { 'BufRead Cargo.toml' },
    opts = { -- Taken from LazyVim
        completion = {
            crates = {
                enabled = true,
            },
        },
        lsp = {
            enabled = true,
            actions = true,
            completion = true,
            hover = true,
        },
    },
}
