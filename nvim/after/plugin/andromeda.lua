local status_ok, plugin = pcall(require, "andromeda")
if not status_ok then
	return
end

local setup = {
	preset = "andromeda",
	transparent_bg = true,
	styles = {
		italic = true,
		bold = true,
		underline = true,
		undercurl = true,
	},
}

plugin.setup(setup)
