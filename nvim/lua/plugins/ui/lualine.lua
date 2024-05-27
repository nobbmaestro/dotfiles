local function harpoon_component()
    local mark_idx = require("harpoon.mark").get_current_index()
    return mark_idx ~= nil and string.format(" %d", mark_idx) or ""
end

local function sleuth_component()
    return vim.g.loaded_sleuth == 1 and vim.fn.SleuthIndicator() or ""
end

local function lsp_server_component()
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
    if next(buf_client_names) == nil then
        return ""
    else
        return string.format("[%s]", table.concat(buf_client_names, ", "))
    end
end

return {
    "nvim-lualine/lualine.nvim",
    lazy = true,
    event = { "VimEnter" },
    dependencies = { "nvim-tree/nvim-web-devicons" },

    config = function()
        local andromeda_lualine = require("andromeda.plugins.lualine")
        require("lualine").setup({
            options = {
                icons_enabled = true,
                theme = andromeda_lualine.theme,
                component_separators = { left = "", right = "" },
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
                lualine_a = { "mode" },
                lualine_b = { "branch", "diff" },
                lualine_c = {
                    { harpoon_component },
                    { "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
                    { "filename", path = 1, symbols = { modified = "  ", readonly = "", unnamed = "" } },
                },
                lualine_x = {
                    {
                        "diagnostics",
                        symbols = { error = "✘", hint = "⚑", info = "»", warn = "▲" },
                    },
                    { sleuth_component },
                },
                lualine_y = {
                    { "progress", padding = { left = 1, right = 1 } },
                    { "location", padding = { left = 0, right = 1 } },
                },
                lualine_z = {
                    { "filetype", icon_only = false, separator = "", padding = { left = 1, right = 0 } },
                    { lsp_server_component },
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
