local status_ok, plugin = pcall(require, "nvim_comment")
if not status_ok then
	return
end

local setup = {
	-- linters prefer comment and line to have a space in between markers
	marker_padding = true,
	-- should comment out empty or whitespace only lines
	comment_empty = false,
	-- trim emptry comment whitespace
	comment_empty_trim_whitespace = true,
}

plugin.setup(setup)
