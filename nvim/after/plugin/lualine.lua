local andromeda_lualine = require("andromeda.plugins.lualine")

require("lualine").setup({
	options = {
		icons_enabled = true,
		theme = andromeda_lualine.theme,
		component_separators = { left = "", right = "" },
		section_separators = { left = "", right = "" },
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
	sections = andromeda_lualine.sections,
	inactive_sections = andromeda_lualine.inactive_sections,
	tabline = {},
	winbar = {},
	inactive_winbar = {},
	extensions = {},
})
