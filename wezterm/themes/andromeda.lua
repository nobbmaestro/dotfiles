local colors = {
	text = "#d5ced9",
	base = "#23262e",

	mono_1 = "#2f323c",
	mono_2 = "#3a3e4b",
	mono_3 = "#464959",
	mono_4 = "#606064",
	mono_5 = "#a0a1a7",
	mono_6 = "#d5ced9",

	black = "#45475a",
	red = "#ee5d43",
	green = "#96e072",
	yellow = "#ffe66d",
	blue = "#7cb7ff",
	hot_pink = "#ff00aa",
	cyan = "#00e8c6",
	white = "#d5ced9",
}

return {
	foreground = colors.text,
	background = colors.base,

	selection_fg = colors.text,
	selection_bg = colors.mono_3,

	cursor_bg = colors.white,
	cursor_fg = colors.base,
	cursor_border = colors.mono_5,

	split = colors.mono_3,

	-- The 16 terminal colors
	ansi = {
		colors.black,
		colors.red,
		colors.green,
		colors.yellow,
		colors.blue,
		colors.hot_pink,
		colors.cyan,
		colors.white,
	},

	brights = {
		"#585B70",
		colors.red,
		colors.green,
		colors.yellow,
		colors.blue,
		colors.hot_pink,
		colors.cyan,
		colors.white,
	},

	indexed = { [16] = colors.blue, [17] = colors.cyan },
}
