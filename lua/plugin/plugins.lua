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

	-- Colorscheme related plugins
	use('nvim-treesitter/nvim-treesitter') -- Set of languge parsers for better syntax highlighting

	use({ 'tiagovla/tokyodark.nvim', after = 'nvim-treesitter' })
	use({ 'catppuccin/nvim', as = 'catppuccin', after = 'nvim-treesitter' })

	-- Fuzzy text searcher
	use({
		'nvim-telescope/telescope.nvim',
		opt = true,
		cmd = { 'Telescope' },
		config = function()
			require('plugin.telescope')
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

	use({ 'L3MON4D3/LuaSnip', after = 'nvim-cmp' })
	use({ 'saadparwaiz1/cmp_luasnip', after = 'nvim-cmp' })

	use('jose-elias-alvarez/null-ls.nvim')

	use({
		'akinsho/toggleterm.nvim',
		tag = 'v2.*',
		cmd = { 'ToggleTerm' },
		config = function()
			local toggleterm_status_ok, toggleterm = pcall(require, 'toggleterm')
			if not toggleterm_status_ok then
				return
			end

			toggleterm.setup({
				open_mapping = [[<C-\>]],
				insert_mappings = true,
				terminal_mappings = true,
			})
		end,
	})

	if PACKER_BOOTSTRAP then
		require('packer').sync()
	end
end)
