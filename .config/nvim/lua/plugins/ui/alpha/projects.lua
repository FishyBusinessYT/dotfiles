local make_button = require('plugins.ui.alpha.buttons').make_button
local get_projects = require('plugins.ui.alpha.project-list').get_projects

local M = {}

local function make_projects()
    local projects = {}
    for i, path in ipairs(get_projects()) do
        local button = make_button(
            tostring(i),
            string.gsub(path, vim.fs.normalize('~'), '~'),
            '<cmd>exe \'cd\' \'' .. path .. '\' <CR>'
        )
        table.insert(projects, button)
    end
    return projects
end

M.projects = {
    type = 'group',
    val = make_projects(),
    opts = { spacing = 1 },
}

return M
