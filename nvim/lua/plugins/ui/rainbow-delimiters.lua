local status_ok, plugin = pcall(require, "rainbow-delimiters")
if not status_ok then
	return
end

vim.g.rainbow_delimiters = {
	strategy = {
		[""] = plugin.strategy["global"],
		vim = plugin.strategy["local"],
	},
	query = {
		[""] = "rainbow-delimiters",
		lua = "rainbow-blocks",
	},
	highlight = {
		"RainbowDelimiterYellow",
		"RainbowDelimiterViolet",
		"RainbowDelimiterBlue",
		"RainbowDelimiterYellow",
		"RainbowDelimiterViolet",
		"RainbowDelimiterBlue",
	},
}
