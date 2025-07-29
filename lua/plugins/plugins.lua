-- Install lazy.nvim plugin manager
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		'git',
		'clone',
		'--filter=blob:none',
		'https://github.com/folke/lazy.nvim.git',
		'--branch=stable', -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

local plugins = {
	'nvim-lua/plenary.nvim', -- Useful lua functions used by lots of plugins

	----- UI related plugins

	-- Colorschemes
	-- 'tiagovla/tokyodark.nvim',
	{
		'catppuccin/nvim',
		version = '*',
		lazy = false, -- make sure we load this during startup if it is your main colorscheme
		priority = 1000, -- make sure to load this before all the other start plugins
		name = 'catppuccin',
		config = function()
			require('ui.catppuccin')
		end,
	},
	-- 'sainnhe/gruvbox-material',
	-- 'sainnhe/everforest',
	-- 'shaunsingh/nord.nvim',

	-- Statusline at the bottom
	{
		'nvim-lualine/lualine.nvim',
		commit = 'a94fc68960665e54408fe37dcf573193c4ce82c9',
		config = function()
			require('ui.lualine')
		end,
	},

	-- Highlighting todo comments
	{
		'folke/todo-comments.nvim',
		event = 'VeryLazy',
		opt = true,
		opts = {},
	},

	-- Highlighting color codes
	{
		'catgoose/nvim-colorizer.lua',
		event = 'BufRead',
		opts = {},
	},

	----- Little useful utils

	-- All in one
	{
		'echasnovski/mini.nvim',
		version = '*',
		config = function()
			require('plugins.mini')
		end,
	},

	-- Fuzzy text searcher
	{
		'ibhagwan/fzf-lua',
    tag = '0.7',
		cmd = 'FzfLua',
		opts = {
			winopts = {
				height = 0.3, -- short height like Ivy
				width = 1.0, -- full width
				row = 1.0, -- bottom of the screen
				anchor = 'S', -- anchor to bottom(south)
				border = 'none', -- optional, no border like Ivy
				fullscreen = false,
			},
			defaults = { file_icons = 'mini' },
			files = { previewer = false },
			oldfiles = { previewer = false },
			git = { files = { previewer = false } },
		},
	},

	-- Floating terminal
	{
		dir = vim.fn.stdpath('config') .. '/lua/plugins/floatterm/',
		name = 'floatterm',
		cmd = 'FloatTerm',
		config = function()
			require('plugins.floatterm')
		end,
		keys = {
			{
				mode = { 'n', 'i', 't' },
				'<C-\\>',
				function()
					require('plugins.floatterm').toggle()
				end,
				desc = 'Toggle Floating Terminal',
			},
		},
	},

	----- Language support

	-- Helps install tools such as lsp, formatter, linters etc
	{
		'williamboman/mason.nvim',
		config = function()
			require('language_support.mason')
		end,
	},

	-- Set of languge parsers for better syntax highlighting
	{
		'nvim-treesitter/nvim-treesitter',
		config = function()
			require('language_support.treesitter')
		end,
	},

	-- Formatting and diagnostics support
	{
		'stevearc/conform.nvim',
		opts = {
			default_format_opts = { lsp_format = 'fallback' },
			formatters_by_ft = {
				c = { 'clangformat' },
				cpp = c,
				go = { 'golines' },
				lua = { 'stylua' },
				javascript = { 'prettierd' },
				typescript = javascript,
				javascriptreact = javascript,
				typescriptreact = typescript,
			},
			format_on_save = {
				timeout_ms = 500,
			},
		},
	},

	{
		'mfussenegger/nvim-lint',
		config = function()
			require('language_support.nvim_lint')
		end,
	},

	-- Language server protocol support
	{
		'neovim/nvim-lspconfig',
		cmd = 'LspStart',
		dependencies = {
			'williamboman/mason-lspconfig.nvim',
		},
		config = function()
			require('language_support.lsp')
		end,
	},
	-- Lsp status
	{
		'j-hui/fidget.nvim',
		event = 'VeryLazy',
		tag = 'v1.6.1',
		opt = true,
		opts = {
			notification = {
				window = {
					winblend = 0,
				},
			},
		},
	},

	-- Autocomplete support
	{
		'hrsh7th/nvim-cmp',
		event = 'InsertEnter',
		dependencies = {
			'hrsh7th/cmp-buffer',
			'hrsh7th/cmp-path',
			'L3MON4D3/LuaSnip',
			'saadparwaiz1/cmp_luasnip',
			'onsails/lspkind.nvim',
		},
		config = function()
			require('language_support.cmp')
		end,
	},
	{
		'hrsh7th/cmp-nvim-lua',
		ft = 'lua',
	},
	{
		'hrsh7th/cmp-nvim-lsp',
		event = 'LspAttach',
		dependencies = {
			'hrsh7th/cmp-nvim-lsp-signature-help',
		},
	},

	----- Git
	-- Git indicators on the signcolumn
	{
		'lewis6991/gitsigns.nvim',
		opt = true,
		opts = {
			current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
			current_line_blame_opts = {
				virt_text = true,
				virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
				delay = 1000,
				ignore_whitespace = false,
			},
			current_line_blame_formatter = '<author>, <author_time:%Y-%m-%d> - <summary>',
			sign_priority = 6,
			update_debounce = 100,
		},
	},

	-- Greatest plugin to ever exist :)
	{
		'tpope/vim-fugitive',
		cmd = { 'Git', 'Gwrite' },
	},

	-- A beautiful undo tree view
	{
		'jiaoshijie/undotree',
		dependencies = 'nvim-lua/plenary.nvim',
		config = true,
		keys = {
			{ '<leader>u', "<cmd>lua require('undotree').toggle()<cr>" },
		},
	},
}

local opts = {
	ui = {
		-- a number <1 is a percentage., >1 is a fixed size
		size = { width = 0.8, height = 0.8 },
		wrap = true, -- wrap the lines in the ui
		-- The border to use for the UI window. Accepts same border values as |nvim_open_win()|.
		border = 'none',
		title = nil, ---@type string only works when border is not "none"
		title_pos = 'center', ---@type "center" | "left" | "right"
		-- Show pills on top of the Lazy window
		pills = true, ---@type boolean
		icons = {
			cmd = ' ',
			config = '',
			event = '',
			ft = ' ',
			init = ' ',
			import = ' ',
			keys = ' ',
			lazy = '󰒲 ',
			loaded = '',
			not_loaded = '',
			plugin = ' ',
			runtime = ' ',
			require = '󰢱 ',
			source = ' ',
			start = '',
			task = '✔ ',
			list = {
				'',
				'',
				'',
				'',
			},
		},
	},
	performance = {
		cache = {
			enabled = true,
		},
		reset_packpath = true, -- reset the package path to improve startup time
		rtp = {
			reset = true, -- reset the runtime path to $VIMRUNTIME and your config directory
			---@type string[]
			paths = {}, -- add any custom paths here that you want to includes in the rtp
			---@type string[] list any plugins you want to disable here
			disabled_plugins = {
				'gzip',
				'matchit',
				'matchparen',
				'tohtml',
				'tutor',
				'zipPlugin',
				'netrw',
				'netrwPlugin',
			},
		},
	},
}

require('lazy').setup(plugins, opts)

-- Load file picker when nvim is launched without any arguments
vim.api.nvim_create_autocmd('VimEnter', {
	callback = function()
		if vim.fn.argc() == 0 then
			vim.schedule(function()
				vim.cmd('FzfLua files')
			end)
		end
	end,
})
