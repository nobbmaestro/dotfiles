require("nvim_comment").setup({
    -- linters prefer comment and line to have a space in between markers
    marker_padding = true,
	-- should comment out empty or whitespace only lines
	comment_empty = false,
	-- trim emptry comment whitespace
	comment_empty_trim_whitespace = true,
})
