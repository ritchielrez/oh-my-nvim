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

	-- UI related plugins
	'nvim-treesitter/nvim-treesitter', -- Set of languge parsers for better syntax highlighting

	'tiagovla/tokyodark.nvim',
	{
		'catppuccin/nvim',
		name = 'catppuccin',
		lazy = false, -- make sure we load this during startup if it is your main colorscheme
		priority = 1000, -- make sure to load this before all the other start plugins
	},
	{
		'sainnhe/gruvbox-material',
	},
	'sainnhe/everforest',
	'shaunsingh/nord.nvim',
	'kyazdani42/nvim-web-devicons',
	'nvim-lualine/lualine.nvim',

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
		event = 'VeryLazy',
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

	-- Formatting support
	{
		'stevearc/conform.nvim',
		event = 'BufWritePre',
		cmd = { 'ConformInfo' },
		keys = {
			{
				'<leader>lf',
				function()
					require('conform').format({ async = true, lsp_fallback = true })
				end,
				mode = '',
				desc = 'Format buffer',
			},
		},
		opts = {
			formatters_by_ft = {
				lua = { 'stylua' },
			},
		},
	},

	-- Diagnostics support
	{
		'mfussenegger/nvim-lint',
		config = function()
			require('lint').linters_by_ft = {
				gitcommit = { 'commitlint' },
				lua = { 'selene' },
			}
			vim.api.nvim_create_autocmd({ 'BufWritePost', 'BufReadPost', 'InsertLeave' }, {
				callback = function()
					require('lint').try_lint()
				end,
			})
		end,
	},

	-- Language server protocol support
	{
		'williamboman/mason.nvim',
		event = 'VeryLazy',
		dependencies = {
			'williamboman/mason-lspconfig.nvim',
			'neovim/nvim-lspconfig',
		},
		config = function()
			require('lsp.lsp')
		end,
	},

	{
		'hrsh7th/nvim-cmp',
		event = 'InsertEnter',
		dependencies = {
			'hrsh7th/cmp-nvim-lsp',
			'hrsh7th/cmp-buffer',
			'hrsh7th/cmp-path',
			'hrsh7th/cmp-nvim-lua',
			'hrsh7th/cmp-nvim-lsp-signature-help',
			'L3MON4D3/LuaSnip',
			'saadparwaiz1/cmp_luasnip',
		},
		config = function()
			require('lsp.cmp')
		end,
	},

	{
		'lvimuser/lsp-inlayhints.nvim',
		event = 'LspAttach',
		config = function()
			require('lsp.inlayhints')
		end,
	},

	'onsails/lspkind.nvim',

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
	-- Git
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
	'tpope/vim-fugitive',

	-- Debugging
	{
		'mfussenegger/nvim-dap',
		event = 'VeryLazy',
		dependencies = 'rcarriga/nvim-dap-ui',
		config = function()
			require('dap.dapui')
		end,
	},
	{
		'leoluz/nvim-dap-go',
		ft = 'go',
	},

	-- Markdown
	{
		'iamcco/markdown-preview.nvim',
		build = function()
			vim.fn['mkdp#util#install']()
		end,
		config = function()
			vim.g.mkdp_echo_preview_url = 1
		end,
	},

	-- Highlighting todo comments
	{
		'folke/todo-comments.nvim',
		opt = true,
		opts = {},
	},
}

local opts = {
	install = {
		colorscheme = { 'default' },
	},
}

require('lazy').setup(plugins, opts)
