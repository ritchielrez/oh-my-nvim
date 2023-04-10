local null_ls_ok, null_ls = pcall(require, 'null-ls')
if not null_ls_ok then
	print('Null-ls plugin not installed')
end

null_ls.setup({
	sources = {
		null_ls.builtins.formatting.clang_format,
		null_ls.builtins.formatting.goimports,
		null_ls.builtins.formatting.stylua,

		null_ls.builtins.code_actions.gitsigns,
	},
})
