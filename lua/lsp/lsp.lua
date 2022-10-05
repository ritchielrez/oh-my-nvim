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
	'sumneko_lua',
	'gopls',
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
	ensure_installed = servers,
	automatic_installation = true,
})

local opts = {}

local function lsp_diagnostics()
	local icons = require('defaults.icons')

	local signs = {
		{ name = 'DiagnosticSignError', text = icons.diagnostics.Error },
		{ name = 'DiagnosticSignWarn', text = icons.diagnostics.Warning },
		{ name = 'DiagnosticSignHint', text = icons.diagnostics.Hint },
		{ name = 'DiagnosticSignInfo', text = icons.diagnostics.Information },
	}

	for _, sign in ipairs(signs) do
		vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = '' })
	end

	local config = {
		virtual_lines = false,
		virtual_text = false,
		-- virtual_text = {
		--   -- spacing = 7,
		--   -- update_in_insert = false,
		--   -- severity_sort = true,
		--   -- prefix = "<-",
		--   prefix = " ●",
		--   source = "if_many", -- Or "always"
		--   -- format = function(diag)
		--   --   return diag.message .. "blah"
		--   -- end,
		-- },

		-- show signs
		signs = {
			active = signs,
		},
		update_in_insert = true,
		underline = true,
		severity_sort = true,
		float = {
			focusable = true,
			style = 'minimal',
			border = 'none',
			-- border = {"▄","▄","▄","█","▀","▀","▀","█"},
			source = 'if_many', -- Or "always"
			header = '',
			prefix = '',
			-- width = 40,
		},
	}

	vim.diagnostic.config(config)

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
	vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gl', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
	vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
	vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
	vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
	vim.api.nvim_buf_set_keymap(bufnr, 'n', '[d', '<cmd>lua vim.diagnostic.goto_prev({ border = "rounded" })<CR>', opts)
	vim.api.nvim_buf_set_keymap(bufnr, 'n', ']d', '<cmd>lua vim.diagnostic.goto_next({ border = "rounded" })<CR>', opts)
	vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)
end

local function on_attach(client, bufnr)
	lsp_diagnostics()
	lsp_keymaps(bufnr)

	if client.name == 'sumneko_lua' then
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
		capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities()),
	}

	server = vim.split(server, '@')[1]

	if server == 'sumneko_lua' then
		local sumneko_lua_opts = require('lsp.settings.sumneko_lua')
		opts = vim.tbl_deep_extend('force', sumneko_lua_opts, opts)
	end

	lspconfig[server].setup(opts)
	::continue::
end
