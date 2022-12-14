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
	use('nvim-treesitter/nvim-treesitter') -- Set of languge parsers for better syntax highlighting

	use({ 'tiagovla/tokyodark.nvim', after = 'nvim-treesitter' })
	use({ 'catppuccin/nvim', as = 'catppuccin', after = 'nvim-treesitter' })
	use({ 'sainnhe/gruvbox-material', after = 'nvim-treesitter' })
	use({ 'sainnhe/everforest', after = 'nvim-treesitter' })
    use('kyazdani42/nvim-web-devicons')
	use('nvim-lualine/lualine.nvim')

	-- Fuzzy text searcher
	use({
		'nvim-telescope/telescope.nvim',
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

	-- Integrated terminal
	use({ 'voldikss/vim-floaterm', cmd = { 'FloatermToggle' } })

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
