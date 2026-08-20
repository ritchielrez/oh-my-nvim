-- Install parsers and their queries:
local ensure_installed = {
	'c',
	'cpp',
	'lua',
	'vim',
	'vimdoc',
	'query',
	'markdown',
	'markdown_inline',
	'slint',
	'rust',
	'go',
	'html',
	'css',
	'javascript',
	'typescript',
}

require('nvim-treesitter.configs').setup({
	ensure_installed = { 'c', 'cpp', 'lua', 'vim', 'vimdoc', 'query', 'markdown', 'markdown_inline', 'slint', 'rust' },
	sync_installed = true,
	highlight = {
		enable = true, -- false will disable the whole extension
		disable = { '' }, -- list of language that will be disabled
		additional_vim_regex_highlighting = false,
	},
})

-- treesitter.install(ensure_installed)
--
-- -- Then enable features for all languages. Features are not enabled automatically.
-- vim.api.nvim_create_autocmd('FileType', {
-- 	pattern = ensure_installed,
-- 	callback = function()
-- 		vim.treesitter.start()
-- 	end,
-- })
