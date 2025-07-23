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
		lazy = false, -- make sure we load this during startup if it is your main colorscheme
		priority = 1000, -- make sure to load this before all the other start plugins
		name = 'catppuccin',
		config = function()
			require('ui.catppuccin')
		end,
	},
	'sainnhe/gruvbox-material',
	'sainnhe/everforest',
	'shaunsingh/nord.nvim',

  -- Fancy Icons
	'kyazdani42/nvim-web-devicons',

	-- Statusline at the bottom
	{
		'nvim-lualine/lualine.nvim',
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
		config = function()
			require('toggleterm').setup({
				size = function(term)
					if term.direction == 'vertical' then
						return vim.o.columns * 0.4
					else
						return 20
					end
				end,
				open_mapping = [[<c-\>]],
				terminal_mappings = true,
				normal_mappings = true,
				insert_mappings = true,
				persist_size = true,
				direction = 'float',
				float_opts = {
					border = 'rounded',
					height = 30,
					width = 150,
				},
			})
		end,
	},

	-- Integrated file manager
	{
		'is0n/fm-nvim',
		config = function()
			require('fm-nvim').setup({
				-- (Vim) Command used to open files
				edit_cmd = 'edit',
				on_close = {},
				on_open = {},
				-- UI Options
				ui = {
					default = 'float',
					float = {
						-- Floating window border (see ':h nvim_open_win')
						border = 'none',
						-- Highlight group for floating window/border (see ':h winhl')
						float_hl = 'Normal',
						border_hl = 'FloatBorder',
						-- Floating Window Transparency (see ':h winblend')
						blend = 0,
						-- Num from 0 - 1 for measurements
						height = 0.8,
						width = 0.8,
						-- X and Y Axis of Window
						x = 0.5,
						y = 0.5,
					},
				},
				-- Terminal commands used w/ file manager (have to be in your $PATH)
				cmds = {
					lf_cmd = 'lf',
				},
				-- Mappings used with the plugin
				mappings = {
					vert_split = '<C-v>',
					horz_split = '<C-h>',
					tabedit = '<C-t>',
					ESC = 'q',
				},
			})
		end,
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

	----- Markdown
	{
		'brianhuster/live-preview.nvim',
		ft = 'markdown',
		opts = {},
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
