local status_ok, plugin = pcall(require, "indent_blankline")
if not status_ok then
	return
end

local setup = {
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
}

plugin.setup(setup)
