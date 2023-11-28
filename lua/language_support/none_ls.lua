local none_ls_status_ok, none_ls = pcall(require, 'null-ls')
if not none_ls_status_ok then
	print('None-ls plugin not installed')
end

require('language_support.diagnostics')

none_ls.setup({
	sources = {
		none_ls.builtins.formatting.clang_format,
		none_ls.builtins.formatting.goimports,
		none_ls.builtins.formatting.stylua,
		none_ls.builtins.formatting.yamlfmt,

        none_ls.builtins.diagnostics.commitlint,
        none_ls.builtins.diagnostics.selene,

		none_ls.builtins.code_actions.gitsigns,
	},
})
