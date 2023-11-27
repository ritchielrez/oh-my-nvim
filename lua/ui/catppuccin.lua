local transparent_background = false

if not vim.g.neovide then
	transparent_background = true
	vim.g.gruvbox_material_transparent_background = 2
	vim.g.everforest_transparent_background = 1
end

vim.g.catppuccin_flavour = 'mocha' -- latte, frappe, macchiato, mocha

local catppuccin_status_ok, catppuccin = pcall(require, 'catppuccin')
if not catppuccin_status_ok then
	return
end

catppuccin.setup({
	no_italic = true,
	dim_inactive = {
		enabled = false,
		shade = 'dark',
		percentage = 0.15,
	},
	transparent_background = transparent_background,
	term_colors = false,
	compile = {
		enabled = false,
		path = vim.fn.stdpath('cache') .. '/catppuccin',
	},
	styles = {
		comments = {},
		conditionals = {},
		loops = {},
		functions = {},
		keywords = {},
		strings = {},
		variables = {},
		numbers = {},
		booleans = {},
		properties = {},
		types = {},
		operators = {},
	},
	integrations = {
		treesitter = true,
		native_lsp = {
			enabled = true,
			virtual_text = {
				errors = {},
				hints = {},
				warnings = {},
				information = {},
			},
			underlines = {
				errors = { 'undercurl' },
				hints = { 'undercurl' },
				warnings = { 'undercurl' },
				information = { 'undercurl' },
			},
		},
		coc_nvim = false,
		lsp_trouble = false,
		cmp = true,
		lsp_saga = false,
		gitgutter = false,
		gitsigns = true,
		leap = false,
		telescope = true,
		nvimtree = {
			enabled = true,
			show_root = true,
			transparent_panel = false,
		},
		neotree = {
			enabled = false,
			show_root = true,
			transparent_panel = false,
		},
		dap = {
			enabled = false,
			enable_ui = false,
		},
		which_key = false,
		indent_blankline = {
			enabled = true,
			colored_indent_levels = false,
		},
		dashboard = true,
		neogit = false,
		vim_sneak = false,
		fern = false,
		barbar = false,
		bufferline = true,
		markdown = true,
		lightspeed = false,
		ts_rainbow = false,
		hop = false,
		notify = true,
		telekasten = true,
		symbols_outline = true,
		mini = false,
		aerial = false,
		vimwiki = true,
		beacon = true,
		navic = false,
		overseer = false,
	},
	color_overrides = {},
	highlight_overrides = {},
})
