local M = {}

local plugin_conf = require("custom.plugins.configs")
local userPlugins = require("custom.plugins")

M.plugins = {
	options = {
		lspconfig = {
			setup_lspconf = "custom.plugins.lspconfig",
		},
	},

	default_plugin_config_replace = {
		nvim_tree = plugin_conf.nvimtree,
	},

	install = userPlugins,
}

M.ui = {
	theme = "chadracula",
}

return M
