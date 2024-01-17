local nvim_lint_ok, nvim_lint = pcall(require, 'lint')
if not nvim_lint_ok then
	print('Nvim-lint plugin not installed')
end

local filetypes = {
	'c',
	'cpp',
	'go',
	'lua',
	'yaml',
	'javscript',
	'typescript',
}

nvim_lint.linters_by_ft = {
	c = { 'cpplint' },
	cpp = { 'cpplint' },
	go = { 'golangcilint' },
	lua = { 'selene' },
	yaml = { 'yamllint' },
	javscript = { 'eslint_d' },
	typescript = { 'eslint_d' },
}

local plugin_name = 'nvim-lint'

vim.api.nvim_create_autocmd({ 'BufRead' }, {
	callback = function()
		for _, filetype in pairs(filetypes) do
			if vim.bo.filetype == filetype then
				vim.notify('Running diagnostics', 'info', {
					title = plugin_name,
					timeout = 500,
				})
			end
		end
	end,
})
vim.api.nvim_create_autocmd({ 'InsertLeave', 'TextChanged', 'BufWritePost' }, {
	callback = function()
		nvim_lint.try_lint()
	end,
})
