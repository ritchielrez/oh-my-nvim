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

require('lazy').setup({
    'nvim-lua/plenary.nvim', -- Useful lua functions used by lots of plugins

    -- UI related plugins
    'nvim-treesitter/nvim-treesitter', -- Set of languge parsers for better syntax highlighting

    'tiagovla/tokyodark.nvim',
    { 'catppuccin/nvim',       name = 'catppuccin' },
    'sainnhe/gruvbox-material',
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

    -- Fuzzy text searcher
    {
        'nvim-telescope/telescope.nvim',
        cmd = { 'Telescope' },
        config = function()
            require('plugins.telescope')
        end,
    },

    -- Language server protocol support
    'j-hui/fidget.nvim',
    {
        'williamboman/mason.nvim',
        dependencies = 'williamboman/mason-lspconfig.nvim',
        config = function()
            require('lsp.lsp')
        end,
    },
    'neovim/nvim-lspconfig',

    {
        'hrsh7th/nvim-cmp',
        dependencies = {
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-path',
            'hrsh7th/cmp-nvim-lua',
            'hrsh7th/cmp-nvim-lsp-signature-help',
            'L3MON4D3/LuaSnip',
            'saadparwaiz1/cmp_luasnip',
        },
    },

    {
        'Fildo7525/pretty_hover',
        event = 'LspAttach',
        config = function()
            require('lsp.pretty_hover')
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

    'jose-elias-alvarez/null-ls.nvim',

    -- Integrated terminal
    { 'voldikss/vim-floaterm', cmd = { 'FloatermToggle' } },

    -- Git
    {
        'lewis6991/gitsigns.nvim',
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
                enable = true,
            },
        },
    },
    'tpope/vim-fugitive',
    {
        'seanbreckenridge/yadm-git.vim',
        config = function()
            vim.g.yadm_git_gitgutter_enabled = 0
        end,
    },

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
})
