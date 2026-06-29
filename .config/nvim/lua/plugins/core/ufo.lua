local virtualTextHandler = function(virtText, _lNum, _endLNum, lWidth, trunc)
    -- This stores the result
    local newVirtText = {}

    local suffix = ' ... '
    local suffWidth = vim.fn.strdisplaywidth(suffix)
    local targetWidth = lWidth - suffWidth
    local currWidth = 0

    -- virtText is a table in the form {{str, any}, ...} where str is the text
    -- we care about and any is the highlight group for that text.
    for _, chunk in ipairs(virtText) do
        local chunkText = chunk[1]
        -- This appears to just return the amount of characters the text
        -- occupies on-screen
        local chunkWidth = vim.fn.strdisplaywidth(chunkText)

        if targetWidth > currWidth + chunkWidth then
            table.insert(newVirtText, chunk)
        else
            -- Truncate text to fit available space (desired width is the 2nd arg)
            chunkText = trunc(chunkText, targetWidth - currWidth)

            -- Insert and break out of the loop
            local newChunk = { chunkText, chunk[2] }
            table.insert(newVirtText, newChunk)
            break
        end
        currWidth = currWidth + chunkWidth
    end
    table.insert(newVirtText, { suffix, 'MoreMsg' })
    return newVirtText
end

return {
    'kevinhwang91/nvim-ufo',
    dependencies = { 'kevinhwang91/promise-async' },

    ---@module 'nvim-ufo'
    ---@type UfoConfig
    opts = {
        open_fold_hl_timeout = 150,
        provider_selector = function(_bufnr, _filetype, _buftype)
            return { 'treesitter', 'indent' }
        end,
        fold_virt_text_handler = virtualTextHandler,
    },
}
