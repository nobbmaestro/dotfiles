local status_ok, plugin = pcall(require, "lualine")
if not status_ok then
    return
end

local andromeda_lualine = require("andromeda.plugins.lualine")

local function harpoon_component()
    local mark_idx = require("harpoon.mark").get_current_index()
    if mark_idx == nil then
        return ""
    end

    return string.format(" %d", mark_idx)
end

local setup = {
    options = {
        icons_enabled = true,
        theme = andromeda_lualine.theme,
        component_separators = { left = "", right = "" },
        section_separators = { left = "", right = "" },
        disabled_filetypes = {
            statusline = {},
            winbar = {},
        },
        ignore_focus = {},
        always_divide_middle = true,
        globalstatus = false,
        refresh = {
            statusline = 1000,
            tabline = 1000,
            winbar = 1000,
        },
    },
    sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch", "diff" },
        lualine_c = {
            { harpoon_component },
            { "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
            { "filename", path = 0, symbols = { modified = "  ", readonly = "", unnamed = "" } },
        },
        lualine_x = {
            {
                "diagnostics",
                symbols = { error = "✘", hint = "⚑", info = "»", warn = "▲" },
            },
        },
        lualine_y = {
            { "progress", padding = { left = 1, right = 0 } },
            { "location", padding = { left = 0, right = 1 } },
        },
        lualine_z = {
            function()
                return " " .. os.date("%R")
            end,
        },
    },
    inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { "filename" },
        lualine_x = { "location" },
        lualine_y = {},
        lualine_z = {},
    },
    tabline = {},
    winbar = {},
    inactive_winbar = {},
    extensions = {},
}

plugin.setup(setup)
