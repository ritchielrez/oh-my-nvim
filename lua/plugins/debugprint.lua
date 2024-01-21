local opts = {
	create_keymaps = false,
	create_commands = true,
}

local debugprint_ok, debugprint = pcall(require, 'debugprint')
if not debugprint_ok then
	print('Debugprint.nvim plugin not installed')
end

debugprint.setup(opts)
vim.keymap.set('n', '<leader>dp', function()
	return debugprint.debugprint()
end, {
	expr = true,
})
vim.keymap.set('n', '<Leader>Dp', function()
	-- Note: setting `expr=true` and returning the value are essential
	return require('debugprint').debugprint({ above = true })
end, {
	expr = true,
})
vim.keymap.set('n', '<Leader>dq', function()
	return require('debugprint').debugprint({ variable = true })
end, {
	expr = true,
})
vim.keymap.set('n', '<Leader>Dq', function()
	return require('debugprint').debugprint({ above = true, variable = true })
end, {
	expr = true,
})
vim.keymap.set('n', '<Leader>do', function()
	-- It's also important to use motion = true for operator-pending motions
	return require('debugprint').debugprint({ motion = true })
end, {
	expr = true,
})
