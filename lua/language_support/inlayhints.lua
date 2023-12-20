local inlayhints_status_ok, inlayhints = pcall(require, 'lsp-inlayhints')
if not inlayhints_status_ok then
	print('Lsp-inlayhints plugin not installed')
end

inlayhints.setup()
vim.api.nvim_create_autocmd('LspAttach', {
	group = vim.api.nvim_create_augroup('LspAttach_inlayhints', {}),
	callback = function(args)
		if not (args.data and args.data.client_id) then
			return
		end
		local client = vim.lsp.get_client_by_id(args.data.client_id)
		inlayhints.on_attach(client, args.buf)
	end,
})

vim.api.nvim_set_hl(0, 'LspInlayHint', { link = 'LspCodeLens' })
