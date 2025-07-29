vim.api.nvim_create_autocmd('LspAttach', {
	group = vim.api.nvim_create_augroup('lsp-attach', {}),
	callback = function(args)
		local bufopt = { noremap = true, silent = true }
		vim.api.nvim_buf_set_keymap(args.buf, 'n', 'gd', '<cmd>FzfLua lsp_definitions<CR>', bufopt)
		vim.api.nvim_buf_set_keymap(args.buf, 'n', 'gD', '<cmd>FzfLua lsp_declarations<CR>', bufopt)
		vim.api.nvim_buf_set_keymap(args.buf, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', bufopt)
		vim.api.nvim_buf_set_keymap(args.buf, 'n', 'gI', '<cmd>FzfLua lsp_implementations<CR>', bufopt)
		vim.api.nvim_buf_set_keymap(args.buf, 'n', 'gr', '<cmd>FzfLua lsp_references<CR>', bufopt)
		vim.api.nvim_buf_set_keymap(args.buf, 'n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<CR>', bufopt)
		vim.api.nvim_buf_set_keymap(args.buf, 'n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', bufopt)
		vim.api.nvim_buf_set_keymap(args.buf, 'n', '<leader>ca', '<cmd>FzfLua lsp_code_actions<CR>', bufopt)
	end,
})

-- Only enable lua_ls by default
vim.lsp.enable('lua_ls')

vim.api.nvim_create_user_command('LspStop', function()
	vim.lsp.stop_client(vim.lsp.get_clients())
end, { nargs = 0 })
