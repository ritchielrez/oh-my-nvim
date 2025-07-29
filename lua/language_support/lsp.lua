local lspconfig_ok, lspconfig = pcall(require, 'lspconfig')
if not lspconfig_ok then
	print('Lspconfig plugin not installed')
end

local servers = {
	'gopls',
	'lua_ls',
	'pyright',
	'clangd',
	'rust_analyzer',
	'vtsls',
	'jsonls',
}

local opt = {}

local function lsp_keymaps(bufnr, lsp_format)
	local bufopt = { noremap = true, silent = true }
	vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>FzfLua lsp_definitions<CR>', bufopt)
	vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<cmd>FzfLua lsp_declarations<CR>', bufopt)
	vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', bufopt)
	vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gI', '<cmd>FzfLua lsp_implementations<CR>', bufopt)
	vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>FzfLua lsp_references<CR>', bufopt)
	vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<CR>', bufopt)
	vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', bufopt)
	vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>ca', '<cmd>FzfLua lsp_code_actions<CR>', bufopt)
end

local function on_attach(client, bufnr)
	local lsp_format = true

	if client.name == 'lua_ls' then
		client.server_capabilities.document_formatting = false
		lsp_format = false
	end

	if client.name == 'gopls' then
		client.server_capabilities.document_formatting = false
		lsp_format = false
	end

	if client.name == 'vtsls' then
		client.server_capabilities.document_formatting = false
		lsp_format = false
	end

	lsp_keymaps(bufnr, lsp_format)
end

for _, server in pairs(servers) do
	opt = {
		autostart = false,
		on_attach = on_attach,
		capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities()),
	}
	opt.capabilities.offsetEncoding = { 'utf-16' }

	server = vim.split(server, '@')[1]

	if server == 'lua_ls' then
		local lua_ls_opts = require('language_support.settings.lua_ls')
		opt = vim.tbl_deep_extend('force', lua_ls_opts, opt)
	end

	lspconfig[server].setup(opt)
	::continue::
end
