local wezterm = require("wezterm")

local config = {
	adjust_window_size_when_changing_font_size = false,
	color_scheme = "Catppuccin Frappe",
	font = wezterm.font("JetBrainsMono Nerd Font"),
	force_reverse_video_cursor = true,
	hide_tab_bar_if_only_one_tab = true,
	window_close_confirmation = "NeverPrompt",
	window_decorations = "RESIZE",
}

return config
