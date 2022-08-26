local fidget_ok, fidget = pcall(require, 'fidget')
if not fidget_ok then
	print('Fidget.nvim plugin not installed')
end

-- Lsp progress status
vim.cmd([[highlight link FidgetTitle Fg]])
vim.cmd([[highlight link FidgetTask Fg]])

fidget.setup({
	text = {
		spinner = 'dots', -- animation shown when tasks are ongoing
		done = require('defaults.icons').ui.Check, -- character shown when all tasks are complete
		commenced = 'Started', -- message shown when task starts
		completed = 'Completed', -- message shown when task completes
	},
	align = {
		bottom = false,
	},
	window = {
		blend = 0,
	},
})
