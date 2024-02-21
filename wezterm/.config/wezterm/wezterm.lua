local wezterm = require("wezterm")

local padding = 10
local config = {}

if wezterm.config_builder then
	config = wezterm.config_builder()
end

config.adjust_window_size_when_changing_font_size = false
config.check_for_updates = false
config.color_scheme = "Catppuccin Mocha"
config.font = wezterm.font("JetBrainsMono Nerd Font")
config.hide_tab_bar_if_only_one_tab = true
config.tab_bar_at_bottom = true
config.use_fancy_tab_bar = false
config.window_close_confirmation = "NeverPrompt"
config.window_padding = {
	left = padding,
	right = padding,
	top = padding,
	bottom = padding,
}

return config
