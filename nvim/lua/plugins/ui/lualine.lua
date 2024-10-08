local function harpoon_component()
    local mark_idx = require("harpoon.mark").get_current_index()
    return mark_idx ~= nil and string.format("󰐃 %d", mark_idx) or ""
end

local function sleuth_component()
    return vim.g.loaded_sleuth == 1 and vim.fn.SleuthIndicator() or ""
end

local function lsp_client_component()
    local buf_clients = vim.lsp.buf_get_clients()
    local null_ls_installed, null_ls = pcall(require, "null-ls")
    local buf_client_names = {}
    for _, client in pairs(buf_clients) do
        if client.name == "null-ls" then
            if null_ls_installed then
                for _, source in ipairs(null_ls.get_source({ filetype = vim.bo.filetype })) do
                    table.insert(buf_client_names, source.name)
                end
            end
        else
            table.insert(buf_client_names, client.name)
        end
    end
    return next(buf_client_names) ~= nil and string.format("[%s]", table.concat(buf_client_names, ", ")) or ""
end

return {
    "nvim-lualine/lualine.nvim",
    lazy = true,
    event = { "VimEnter" },
    dependencies = { "nvim-tree/nvim-web-devicons" },

    config = function()
        local andromeda = require("andromeda.plugins.lualine")
        local colors = require("andromeda.presets.andromeda")

        -- Overwrite theme properties
        andromeda.theme.normal.b = { fg = colors.mono_5, bg = colors.mono_2 }

        require("lualine").setup({
            options = {
                icons_enabled = true,
                theme = andromeda.theme,
                component_separators = { left = "|", right = "" },
                section_separators = { left = "", right = "" },
                disabled_filetypes = {
                    statusline = {},
                    winbar = {},
                },
                ignore_focus = { "neo-tree" },
                always_divide_middle = true,
                globalstatus = true,
                refresh = {
                    statusline = 1000,
                    tabline = 1000,
                    winbar = 1000,
                },
            },
            sections = {
                lualine_a = {
                    { "mode", separator = { right = "", left = "" } },
                },
                lualine_b = {
                    { "branch", color = { fg = colors.green } },
                    { "diff" },
                    { "diagnostics", symbols = { error = "✘", hint = "⚑", info = "»", warn = "▲" } },
                },
                lualine_c = {
                    { harpoon_component, padding = { left = 1, right = 1 }, color = { fg = colors.cyan } },
                    { "filename", path = 1, symbols = { modified = "  ", readonly = "", unnamed = "" } },
                },
                lualine_x = {},
                lualine_y = {
                    { sleuth_component },
                    { "location", padding = { left = 0, right = 1 } },
                    { "progress", padding = { left = 1, right = 1 } },
                },
                lualine_z = {
                    { "filetype", icon_only = false, padding = { left = 1, right = 0 } },
                    { lsp_client_component, separator = { right = "", left = "" } },
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
        })
    end,
}
