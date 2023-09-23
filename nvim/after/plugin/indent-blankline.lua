vim.opt.list = true

require("indent_blankline").setup({
	char = "▏",
	context_char = "▏",
	filetype_exclude = {
		"help",
		"alpha",
		"dashboard",
		"neo-tree",
		"Trouble",
		"lazy",
		"mason",
		"notify",
		"toggleterm",
		"lazyterm",
	},
    show_current_context = true,
})
