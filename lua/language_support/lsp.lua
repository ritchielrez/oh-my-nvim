-- Calling needed plugins
local mason_ok, mason = pcall(require, 'mason')
if not mason_ok then
	print('Mason.nvim plugin not installed')
end

local mason_lspconfig_ok, mason_lspconfig = pcall(require, 'mason-lspconfig')
if not mason_lspconfig_ok then
	print('Mason-lspconfig plugin not installed')
end

local lspconfig_ok, lspconfig = pcall(require, 'lspconfig')
if not lspconfig_ok then
	print('Lspconfig plugin not installed')
end

local servers = {
	'lua_ls',
	'pyright',
	'clangd',
}

mason.setup({
	ui = {
		icons = {
			package_installed = require('defaults.icons').ui.Check,
			package_pending = require('defaults.icons').ui.ChevronRight,
			package_uninstalled = require('defaults.icons').ui.Close,
		},
	},
})

mason_lspconfig.setup({
	automatic_installation = false,
})

local opts = {}

local function lsp_config()
	vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, {
		border = 'none',
		-- width = 60,
		-- height = 30,
	})

	vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help, {
		border = 'none',
		-- width = 60,
		-- height = 30,
	})
end

local function lsp_keymaps(bufnr)
	local opts = { noremap = true, silent = true }
	vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>Telescope lsp_definitions<CR>', opts)
	vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<cmd>Telescope lsp_declarations<CR>', opts)
	vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
	vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gI', '<cmd>Telescope lsp_implementations<CR>', opts)
	vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>Telescope lsp_references<CR>', opts)
	vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
	vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
end

local function on_attach(client, bufnr)
	lsp_config()
	lsp_keymaps(bufnr)

	if client.name == 'lua_ls' then
		client.server_capabilities.document_formatting = false
	end

	if client.name == 'gopls' then
		client.server_capabilities.document_formatting = false
	end
end

for _, server in pairs(servers) do
	opts = {
		autostart = false,
		on_attach = on_attach,
		capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities()),
	}
	opts.capabilities.offsetEncoding = { 'utf-16' }

	server = vim.split(server, '@')[1]

	if server == 'lua_ls' then
		local lua_ls_opts = require('language_support.settings.lua_ls')
		opts = vim.tbl_deep_extend('force', lua_ls_opts, opts)
	end

	lspconfig[server].setup(opts)
	::continue::
end
