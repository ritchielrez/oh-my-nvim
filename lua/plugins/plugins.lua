-- Install packer.nvim plugin manager
local fn = vim.fn
local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
	PACKER_BOOTSTRAP = fn.system({
		'git',
		'clone',
		'--depth',
		'1',
		'https://github.com/wbthomason/packer.nvim',
		install_path,
	})
	print('Installing packer.nvim, close and reopen Neovim...')
	vim.cmd([[packadd packer.nvim]])
end

-- Load packer.nvim plugin manager
local packer_ok, packer = pcall(require, 'packer')
if not packer_ok then
	return
end

-- Install all the needed plugins
return packer.startup(function(use)
	-- Improves startup time, recommended to load before any other plugins
	use({
		'lewis6991/impatient.nvim',
		config = function()
			local impatient_ok, _ = pcall(require, 'impatient')
			if not impatient_ok then
				print('Impatient.nvim plugin not installed')
			end
		end,
	})

	use('wbthomason/packer.nvim') -- Keep packer.nvim up-to-date
	use('nvim-lua/plenary.nvim') -- Useful lua functions used by lots of plugins

	-- UI related plugins
	use({ 'nvim-treesitter/nvim-treesitter' }) -- Set of languge parsers for better syntax highlighting

	use('tiagovla/tokyodark.nvim')
	use({ 'catppuccin/nvim', as = 'catppuccin' })
	use('sainnhe/gruvbox-material')
	use('sainnhe/everforest')
	use('shaunsingh/nord.nvim')
	use('kyazdani42/nvim-web-devicons')
	use('nvim-lualine/lualine.nvim')

	-- Code commenter
	use({
		'numToStr/Comment.nvim',
		config = function()
			local comment_status_ok, comment = pcall(require, 'Comment')
			if not comment_status_ok then
				print('Comment.nvim plugin not installed')
			end
			comment.setup()
		end,
	})

	-- Fuzzy text searcher
	use({
		'nvim-telescope/telescope.nvim',
		cmd = { 'Telescope' },
		config = function()
			require('plugins.telescope')
		end,
	})

	-- Language server protocol support
	use('j-hui/fidget.nvim')
	use('williamboman/mason.nvim')
	use('neovim/nvim-lspconfig')
	use({
		'williamboman/mason-lspconfig.nvim',
		after = 'mason.nvim',
		config = function()
			require('lsp.lsp')
		end,
	})
	use('hrsh7th/nvim-cmp')
	use({ 'hrsh7th/cmp-nvim-lsp', after = 'nvim-cmp' })
	use({ 'hrsh7th/cmp-buffer', after = 'nvim-cmp' })
	use({ 'hrsh7th/cmp-path', after = 'nvim-cmp' })
	use({ 'hrsh7th/cmp-nvim-lua', after = 'nvim-cmp' })
	use({ 'hrsh7th/cmp-nvim-lsp-signature-help', after = 'nvim-cmp' })

	use({
		'Fildo7525/pretty_hover',
		event = 'LspAttach',
		config = function()
            local pretty_hover_status_ok, pretty_hover = pcall(require, pretty_hover)
			pretty_hover.setup(options)
		end,
	})

	use({
		'lvimuser/lsp-inlayhints.nvim',
		event = 'LspAttach',
		config = function()
			require('lsp.inlayhints')
		end,
	})

	use('onsails/lspkind.nvim')

	use({ 'L3MON4D3/LuaSnip', after = 'nvim-cmp' })
	use({ 'saadparwaiz1/cmp_luasnip', after = 'nvim-cmp' })

	use('jose-elias-alvarez/null-ls.nvim')

	-- Integrated terminal
	use({ 'voldikss/vim-floaterm', cmd = { 'FloatermToggle' } })

	-- Git
	use({
		'lewis6991/gitsigns.nvim',
		config = function()
			local gitsigns_status_ok, gitsigns = pcall(require, 'gitsigns')
			if not gitsigns_status_ok then
				print('Gitsigns plugin not installed')
			end
			gitsigns.setup({
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
			})
		end,
	})
	use('tpope/vim-fugitive')

	-- Debugging
	use('mfussenegger/nvim-dap')
	use({
		'rcarriga/nvim-dap-ui',
		after = 'nvim-dap',
		config = function()
			require('dap.dapui')
		end,
	})
	use({
		'leoluz/nvim-dap-go',
		ft = 'go',
	})

	if PACKER_BOOTSTRAP then
		require('packer').sync()
	end
end)
