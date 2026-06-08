-- Treesitter: syntax parser
local treesitter_ok, treesitter = pcall(require, 'nvim-treesitter')
if not treesitter_ok then
	print('Treesitter plugin not installed')
end

-- configs.setup({
-- 	ensure_installed = { 'c', 'cpp', 'lua', 'vim', 'vimdoc', 'query', 'markdown', 'markdown_inline', 'slint', 'rust' },
-- 	sync_installed = false,
-- 	highlight = {
-- 		enable = true, -- false will disable the whole extension
-- 		disable = { '' }, -- list of language that will be disabled
-- 		additional_vim_regex_highlighting = false,
-- 	},
-- })

-- Install parsers and their queries:
local ensure_installed = { 'c', 'cpp', 'lua', 'vim', 'vimdoc', 'query', 'markdown', 'markdown_inline', 'slint', 'rust' }
treesitter.install(ensure_installed)

-- Then enable features for all languages. Features are not enabled automatically.
vim.api.nvim_create_autocmd('FileType', {
	pattern = ensure_installed,
	callback = function()
		vim.treesitter.start()
		vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()" -- indentation
	end,
})
