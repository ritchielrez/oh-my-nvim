-- Treesitter: syntax parser
local treesitter_ok, configs = pcall(require, 'nvim-treesitter.configs')
if not treesitter_ok then
	print('Treesitter plugin not installed')
end

configs.setup({
	ensure_installed = { 'c', 'lua', 'vim', 'vimdoc', 'query', 'markdown', 'markdown_inline', 'slint', 'rust' },
	sync_installed = false,
	highlight = {
		enable = true, -- false will disable the whole extension
		disable = { '' }, -- list of language that will be disabled
		additional_vim_regex_highlighting = false,
	},
	autotag = {
		enable = true,
	},
})
