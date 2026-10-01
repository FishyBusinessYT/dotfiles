return {
    { -- Issues:
        -- * Doesn't work for the <> pair.
        -- * Say you have the following text: [ mini.pairs' ]. Inserting the
        -- missing quote creates an entire pair.
        'nvim-mini/mini.pairs',
        opts = {
            modes = { insert = true, command = true, terminal = true },
        },
    },
}
