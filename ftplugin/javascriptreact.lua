vim.api.nvim_create_user_command('LspStart', function()
	vim.lsp.enable('vtsls')
	vim.cmd.edit()
end, { nargs = 0 })
