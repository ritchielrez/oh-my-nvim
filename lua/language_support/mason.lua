local mason_ok, mason = pcall(require, 'mason')
if not mason_ok then
	print('Mason.nvim plugin not installed')
end

mason.setup({
	ui = {
		icons = {
			package_installed = require('defaults.icons').ui.Check,
			package_pending = require('defaults.icons').ui.ChevronRight,
			package_uninstalled = require('defaults.icons').ui.Close,
		},
	},
})
