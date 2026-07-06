---@type LazySpec
return {
    'nvimtools/none-ls.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = function(_, opts)
        local nls = require('null-ls')
        opts.sources = {
            nls.builtins.formatting.black,
        }
    end,
}
