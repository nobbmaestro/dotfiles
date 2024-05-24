local wezterm = require("wezterm")
local andromeda = require("themes.andromeda")

local config = {
	term = "xterm-256color",

	-- Colorscheme
	colors = andromeda,

	window_background_opacity = 0.9,
	macos_window_background_blur = 32,

	-- Font
	font_size = 13.0,
	line_height = 1.1,
	font = wezterm.font_with_fallback({
		{ family = "JetBrainsMono Nerd Font Mono", weight = "Bold" },
		-- { family = "JetBrains Mono",               weight = "DemiBold" },
		-- { family = "Symbols Nerd Font Mono",       scale = 0.75 },
	}),

	-- General settings
	adjust_window_size_when_changing_font_size = false,
	native_macos_fullscreen_mode = false,
	enable_tab_bar = false,
	window_decorations = "RESIZE",

	window_padding = {
		left = "20px",
		right = "20px",
		top = "20px",
		bottom = "10px",
	},
}

return config
