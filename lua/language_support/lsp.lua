local servers = {}

local config_files = vim.api.nvim_get_runtime_file('lsp/*.lua', true)

-- Get the list of server names from lsp configs in lsp/ folder
-- Got this solution from https://github.com/neovim/neovim/discussions/33978#discussioncomment-13385052
for _, config_file in ipairs(config_files) do
	local name = config_file:match('([^/\\]*)%.lua$')

	if name and (name:len() > 0) then
		table.insert(servers, name)
	end
end

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

for _, server in ipairs(servers) do
	local config = vim.lsp.config[server]
	vim.api.nvim_create_autocmd('FileType', {
		group = vim.api.nvim_create_augroup('lsp_commands', { clear = false }),
		pattern = config.filetypes,
		callback = function()
			vim.api.nvim_create_user_command('LspStart', function()
				vim.lsp.enable(server, true)
				vim.cmd.edit()
			end, { nargs = 0 })
			vim.api.nvim_create_user_command('LspStop', function()
				vim.lsp.enable(server, false)
			end, { nargs = 0 })
		end,
	})
end
