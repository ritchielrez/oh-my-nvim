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
	'tiagovla/tokyodark.nvim',
	{
		'catppuccin/nvim',
		name = 'catppuccin',
		lazy = false, -- make sure we load this during startup if it is your main colorscheme
		priority = 1000, -- make sure to load this before all the other start plugins
		config = function()
			require('ui.catppuccin')
		end,
	},
	{
		'sainnhe/gruvbox-material',
	},
	'sainnhe/everforest',
	'shaunsingh/nord.nvim',
	'kyazdani42/nvim-web-devicons',

	-- Dashboard at startup
	{
		'goolord/alpha-nvim',
		event = 'VimEnter',
		config = function()
			require('alpha').setup(require('plugins.alpha').config)
		end,
	},

	-- Statusline at the bottom
	{
		'nvim-lualine/lualine.nvim',
		config = function()
			require('ui.lualine')
		end,
	},

	-- Nice looking notifications at top left
	{
		'rcarriga/nvim-notify',
		config = function()
			local notify = require('notify')
			notify.setup({
				background_colour = '#000000',
			})
			vim.notify = notify
		end,
	},
	{
		'mrded/nvim-lsp-notify',
		event = 'LspAttach',
		config = function()
			require('lsp-notify').setup({})
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
		'NvChad/nvim-colorizer.lua',
		event = 'BufRead',
		opts = {},
	},

	----- Little useful utils

	-- Code commenter
	{
		'numToStr/Comment.nvim',
		event = 'VeryLazy',
		opts = {},
	},

	-- Autopairs
	{
		'windwp/nvim-autopairs',
		event = 'InsertEnter',
		opts = {},
	},

	-- Fuzzy text searcher
	{
		'nvim-telescope/telescope.nvim',
		cmd = { 'Telescope' },
		dependencies = {
			'nvim-telescope/telescope-project.nvim',
			'nvim-telescope/telescope-ui-select.nvim',
			'nvim-telescope/telescope-file-browser.nvim',
			{
				'nvim-telescope/telescope-fzf-native.nvim',
				build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build',
				-- build = 'make',
			},
		},
		config = function()
			require('plugins.telescope')
		end,
	},

	----- Language support

	-- Set of languge parsers for better syntax highlighting
	{
		'nvim-treesitter/nvim-treesitter',
		config = function()
			require('language_support.treesitter')
		end,
	},

	-- Formatting and diagnostics support
	{
		'mhartington/formatter.nvim',
		cmd = 'Format',
		config = function()
			require('language_support.formatter')
		end,
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
	{
		'williamboman/mason.nvim',
		config = function()
			require('language_support.mason')
		end,
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

	-- Lsp inlayhints
	{
		'lvimuser/lsp-inlayhints.nvim',
		event = 'LspAttach',
		config = function()
			require('language_support.inlayhints')
		end,
	},

	-- Integrated terminal
	{
		'akinsho/toggleterm.nvim',
		event = 'VeryLazy',
		version = '*',
		opts = {
			open_mapping = [[<c-\>]],
			terminal_mappings = true,
			normal_mappings = true,
			insert_mappings = true,
			persist_size = true,
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
			yadm = {
				enable = false,
			},
		},
	},

	-- Greatest plugin to ever exist :)
	{
		'tpope/vim-fugitive',
		cmd = 'Git',
		'Gwrite',
	},

	----- Debugging support
	{
		'mfussenegger/nvim-dap',
		ft = { 'c', 'cpp', 'go' },
		dependencies = 'rcarriga/nvim-dap-ui',
		config = function()
			require('dap.dapui')
		end,
	},
	{
		'leoluz/nvim-dap-go',
		ft = 'go',
	},
	{
		'andrewferrier/debugprint.nvim',
		opt = true,
		config = function()
			require('plugins.debugprint')
		end,
		version = '*',
	},

	----- Markdown
	{
		'iamcco/markdown-preview.nvim',
		cmd = { 'MarkdownPreviewToggle', 'MarkdownPreview', 'MarkdownPreviewStop' },
		ft = { 'markdown' },
		build = function()
			vim.fn['mkdp#util#install']()
		end,
		config = function()
			vim.g.mkdp_echo_preview_url = 1
		end,
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

local opts = {}

require('lazy').setup(plugins, opts)
