vim.opt.termguicolors = true

-- local function set_transparent() -- set UI component to transparent
-- 	local groups = {
-- 		'Normal',
-- 		'NormalNC',
-- 		'EndOfBuffer',
-- 		'NormalFloat',
-- 		'FloatBorder',
-- 		'SignColumn',
-- 		'StatusLine',
-- 		'StatusLineNC',
-- 		'TabLine',
-- 		'TabLineFill',
-- 		'TabLineSel',
-- 		'ColorColumn',
-- 	}
-- 	for _, g in ipairs(groups) do
-- 		vim.api.nvim_set_hl(0, g, { bg = 'none' })
-- 	end
-- 	vim.api.nvim_set_hl(0, 'TabLineFill', { bg = 'none', fg = '#767676' })
-- end
--
-- set_transparent()

-- ============================================================================
-- OPTIONS
-- ============================================================================
vim.opt.number = true -- line number
vim.opt.relativenumber = true -- relative line numbers
vim.opt.cursorline = true -- highlight current line
vim.opt.wrap = false -- do not wrap lines by default
vim.opt.scrolloff = 10 -- keep 10 lines above/below cursor
vim.opt.sidescrolloff = 10 -- keep 10 lines to left/right of cursor

vim.opt.tabstop = 2 -- tabwidth
vim.opt.shiftwidth = 2 -- indent width
vim.opt.softtabstop = 2 -- soft tab stop not tabs on tab/backspace
vim.opt.expandtab = true -- use spaces instead of tabs
vim.opt.smartindent = true -- smart auto-indent
vim.opt.autoindent = true -- copy indent from current line

vim.opt.ignorecase = true -- case insensitive search
vim.opt.smartcase = true -- case sensitive if uppercase in string
vim.opt.hlsearch = false -- highlight search matches
vim.opt.incsearch = true -- show matches as you type

vim.opt.signcolumn = 'yes' -- always show a sign column
vim.opt.colorcolumn = '100' -- show a column at 100 position chars
vim.opt.showmatch = true -- highlights matching brackets
vim.opt.cmdheight = 1 -- single line command line
vim.opt.completeopt = 'menuone,noinsert,noselect' -- completion options
vim.opt.showmode = false -- do not show the mode, instead have it in statusline
vim.opt.pumheight = 10 -- popup menu height
vim.opt.pumblend = 10 -- popup menu transparency
vim.opt.winblend = 0 -- floating window transparency
vim.opt.conceallevel = 0 -- do not hide markup
vim.opt.concealcursor = '' -- do not hide cursorline in markup
vim.opt.lazyredraw = true -- do not redraw during macros
vim.opt.synmaxcol = 300 -- syntax highlighting limit
vim.opt.fillchars = { eob = ' ' } -- hide "~" on empty lines

-- netrw
vim.g.netrw_banner = 0
vim.g.netrw_liststyle = 3

vim.o.winborder = 'rounded' -- floating windows will have rounded borders

local undodir = vim.fn.expand('~/.vim/undodir')
if
	vim.fn.isdirectory(undodir) == 0 -- create undodir if nonexistent
then
	vim.fn.mkdir(undodir, 'p')
end

vim.opt.backup = false -- do not create a backup file
vim.opt.writebackup = false -- do not write to a backup file
vim.opt.swapfile = false -- do not create a swapfile
vim.opt.undofile = true -- do create an undo file
vim.opt.undodir = undodir -- set the undo directory
vim.opt.updatetime = 300 -- faster completion
vim.opt.timeoutlen = 500 -- timeout duration
vim.opt.ttimeoutlen = 0 -- key code timeout
vim.opt.autoread = true -- auto-reload changes if outside of neovim
vim.opt.autowrite = false -- do not auto-save

vim.opt.hidden = true -- allow hidden buffers
vim.opt.errorbells = false -- no error sounds
vim.opt.backspace = 'indent,eol,start' -- better backspace behaviour
vim.opt.autochdir = false -- do not autochange directories
vim.opt.iskeyword:append('-') -- include - in words

-- include certain directories so we can find files in those directories
vim.opt.path:append('src/')
vim.opt.path:append('include/')

vim.opt.selection = 'inclusive' -- include last char in selection
vim.opt.mouse = 'a' -- enable mouse support
vim.opt.clipboard:append('unnamedplus') -- use system clipboard
vim.opt.modifiable = true -- allow buffer modifications
vim.opt.encoding = 'utf-8' -- set encoding

-- Folding: requires treesitter available at runtime; safe fallback if not
vim.opt.foldmethod = 'expr' -- use expression for folding
vim.opt.foldexpr = 'v:lua.vim.treesitter.foldexpr()' -- use treesitter for folding
vim.opt.foldlevel = 99 -- start with all folds open

vim.opt.splitbelow = true -- horizontal splits go below
vim.opt.splitright = true -- vertical splits go right

vim.opt.wildmenu = true -- tab completion
vim.opt.wildmode = 'longest:full,full' -- complete longest common match, full completion list, cycle through with Tab
vim.opt.diffopt:append('linematch:60') -- improve diff display
vim.opt.redrawtime = 10000 -- increase neovim redraw tolerance
vim.opt.maxmempattern = 20000 -- increase max memory

vim.opt.laststatus = 3 -- thinner lines between splits

-- use ripgrep for vim's builtin search
if vim.fn.executable('rg') == 1 then
	vim.opt.grepprg = 'rg --vimgrep --smart-case'
end
vim.cmd(":command! -nargs=+ Grep execute 'silent grep! <args>' | copen") -- opens a quickfix list after searching for the given text

-- ============================================================================
-- KEYMAPS
-- ============================================================================
vim.g.mapleader = ' ' -- space for leader
vim.g.maplocalleader = ' ' -- space for localleader

-- better movement in wrapped text
vim.keymap.set('n', 'j', function()
	return vim.v.count == 0 and 'gj' or 'j'
end, { expr = true, silent = true, desc = 'Down (wrap-aware)' })
vim.keymap.set('n', 'k', function()
	return vim.v.count == 0 and 'gk' or 'k'
end, { expr = true, silent = true, desc = 'Up (wrap-aware)' })

vim.keymap.set('n', 'n', 'nzzzv', { desc = 'Next search result (centered)' })
vim.keymap.set('n', 'N', 'Nzzzv', { desc = 'Previous search result (centered)' })
vim.keymap.set('n', '<C-d>', '<C-d>zz', { desc = 'Half page down (centered)' })
vim.keymap.set('n', '<C-u>', '<C-u>zz', { desc = 'Half page up (centered)' })

vim.keymap.set('x', '<leader>p', '"_dP', { desc = 'Paste without yanking' })
vim.keymap.set({ 'n', 'v' }, '<leader>x', '"_d', { desc = 'Delete without yanking' })

vim.keymap.set('n', '<leader>bn', ':bnext<CR>', { desc = 'Next buffer' })
vim.keymap.set('n', '<leader>bp', ':bprevious<CR>', { desc = 'Previous buffer' })

vim.keymap.set('n', '<C-h>', '<C-w>h', { desc = 'Move to left window' })
vim.keymap.set('n', '<C-j>', '<C-w>j', { desc = 'Move to bottom window' })
vim.keymap.set('n', '<C-k>', '<C-w>k', { desc = 'Move to top window' })
vim.keymap.set('n', '<C-l>', '<C-w>l', { desc = 'Move to right window' })

vim.keymap.set('n', '<leader>"', ':vsplit<CR>', { desc = 'Split window vertically' })
vim.keymap.set('n', '<leader>%', ':split<CR>', { desc = 'Split window horizontally' })
vim.keymap.set('n', '<leader>x', ':q!<CR>', { desc = 'Close window' })
vim.keymap.set('n', '<Up>', ':resize +2<CR>', { desc = 'Increase window height' })
vim.keymap.set('n', '<Down>', ':resize -2<CR>', { desc = 'Decrease window height' })
vim.keymap.set('n', '<Left>', ':vertical resize -2<CR>', { desc = 'Decrease window width' })
vim.keymap.set('n', '<Right>', ':vertical resize +2<CR>', { desc = 'Increase window width' })

vim.keymap.set('n', 'J', ':m .+1<CR>==', { desc = 'Move line down' })
vim.keymap.set('n', 'K', ':m .-2<CR>==', { desc = 'Move line up' })
-- vim.keymap.set('v', '<A-j>', ":m '>+1<CR>gv=gv", { desc = 'Move selection down' })
-- vim.keymap.set('v', '<A-k>', ":m '<-2<CR>gv=gv", { desc = 'Move selection up' })

vim.keymap.set('v', '<', '<gv', { desc = 'Indent left and reselect' })
vim.keymap.set('v', '>', '>gv', { desc = 'Indent right and reselect' })

vim.keymap.set('n', '<leader>pa', function() -- show file path
	local path = vim.fn.expand('%:p')
	vim.fn.setreg('+', path)
	print('file:', path)
end, { desc = 'Copy full file path' })

vim.keymap.set('n', '<leader>td', function()
	vim.diagnostic.enable(not vim.diagnostic.is_enabled())
end, { desc = 'Toggle diagnostics' })

vim.keymap.set('n', '<leader>ff', ':find ', { desc = 'Find files' })
vim.keymap.set('n', '<leader>fs', ':Grep ', { desc = 'Project wide search' })

vim.keymap.set('n', '<leader>e', ':20Lex<CR> ', { desc = 'Open netrw to the left' })

-- git related keymaps
vim.keymap.set({ 'n', 'v' }, '<Leader>gb', ':Gitsigns toggle_current_line_blame<CR>', opts)
vim.keymap.set({ 'n', 'v' }, '<Leader>ghs', ':Gitsigns stage_hunk<CR>', opts)
vim.keymap.set({ 'n', 'v' }, '<Leader>ghr', ':Gitsigns reset_hunk<CR>', opts)
vim.keymap.set('n', '<Leader>gc', ':Git commit<CR>', opts)
vim.keymap.set('n', '<Leader>gp', ':Git! push<CR>', opts)
vim.keymap.set('n', '<Leader>gw', ':Gwrite<CR>', opts)

-- ============================================================================
-- AUTOCMDS
-- ============================================================================

local augroup = vim.api.nvim_create_augroup('UserConfig', { clear = true })

-- highlight yanked text
vim.api.nvim_create_autocmd('TextYankPost', {
	group = augroup,
	callback = function()
		vim.hl.on_yank()
	end,
})

-- return to last cursor position
vim.api.nvim_create_autocmd('BufReadPost', {
	group = augroup,
	desc = 'Restore last cursor position',
	callback = function()
		if vim.o.diff then -- except in diff mode
			return
		end

		local last_pos = vim.api.nvim_buf_get_mark(0, '"') -- {line, col}
		local last_line = vim.api.nvim_buf_line_count(0)

		local row = last_pos[1]
		if row < 1 or row > last_line then
			return
		end

		pcall(vim.api.nvim_win_set_cursor, 0, last_pos)
	end,
})

-- wrap, linebreak and spellcheck on markdown and text files
vim.api.nvim_create_autocmd('FileType', {
	group = augroup,
	pattern = { 'markdown', 'text', 'gitcommit' },
	callback = function()
		vim.opt_local.wrap = true
		vim.opt_local.linebreak = true
		vim.opt_local.spell = true
	end,
})

-- ============================================================================
-- PLUGINS
-- ============================================================================

-- bootstrap lazy.nvim
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
	local out = vim.fn.system({ 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ 'Failed to clone lazy.nvim:\n', 'ErrorMsg' },
			{ out, 'WarningMsg' },
			{ '\nPress any key to exit...' },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath)

local plugins = {
	'nvim-lua/plenary.nvim', -- useful lua functions used by lots of plugins

	----- UI related plugins

	-- colorscheme
	{
		'catppuccin/nvim',
		name = 'catppuccin',
		version = '*',
		lazy = false, -- make sure we load this during startup if it is your main colorscheme
		priority = 1000, -- make sure to load this before all the other start plugins
		config = function()
			local transparent_background = false

			if not vim.g.neovide then
				transparent_background = true
			end

			local catppuccin = require('catppuccin')

			catppuccin.setup({
				flavour = 'mocha',
				dim_inactive = {
					enabled = false,
					shade = 'dark',
					percentage = 0.15,
				},
				transparent_background = transparent_background,
				term_colors = true,
				compile = {
					enabled = false,
					path = vim.fn.stdpath('cache') .. '/catppuccin',
				},
				integrations = {
					treesitter = true,
					rainbow_delimiters = true,
				},
			})

			vim.cmd('colorscheme catppuccin')
		end,
	},

	----- language support

	-- set of languge parsers for better syntax highlighting
	{
		'nvim-treesitter/nvim-treesitter',
		build = ':TSUpdate',
		tag = 'v0.10.0',
		config = function(_, opts)
			require('nvim-treesitter.configs').setup(opts)
		end,
		opts = {
			ensure_installed = { 'c', 'lua', 'vim', 'vimdoc', 'query', 'markdown', 'markdown_inline', 'slint', 'rust' },
			sync_installed = true,
			highlight = {
				enable = true, -- false will disable the whole extension
				disable = { '' }, -- list of language that will be disabled
				additional_vim_regex_highlighting = false,
			},
			indent = { enable = true },
		},
	},

	-- formatting and diagnostics support
	{
		'stevearc/conform.nvim',
		version = '*',
		opts = {
			default_format_opts = { lsp_format = 'fallback' },
			formatters_by_ft = {
				c = { 'clang-format' },
				cpp = { 'clang-format' },
				css = { 'prettier' },
				html = { 'prettier' },
				gleam = { 'gleam' },
				go = { 'golines' },
				lua = { 'stylua' },
				javascript = css,
				typescript = { 'prettier' },
				javascriptreact = { 'prettier' },
				typescriptreact = { 'prettier' },
			},
			format_on_save = {
				timeout_ms = 500,
			},
		},
	},

	{
		'mfussenegger/nvim-lint',
		commit = '9c6207559297b24f0b7c32829f8e45f7d65b991f',
		config = function()
			local nvim_lint = require('lint')
			local plugin_name = 'nvim-lint'

			local filetypes = {
				'c',
				'cpp',
				'go',
				'lua',
				'yaml',
			}

			nvim_lint.linters_by_ft = {
				-- c = { 'cpplint' },
				-- cpp = { 'cpplint' },
				c = { 'clangtidy' },
				go = { 'golangcilint' },
				lua = { 'selene' },
				yaml = { 'yamllint' },
			}

			vim.api.nvim_create_autocmd({ 'BufRead' }, {
				callback = function()
					for _, filetype in pairs(filetypes) do
						if vim.bo.filetype == filetype then
							vim.notify('Running diagnostics', 'info', {
								title = plugin_name,
								timeout = 500,
							})
						end
					end
				end,
			})
			vim.api.nvim_create_autocmd({ 'InsertLeave', 'TextChanged', 'BufWritePost' }, {
				callback = function()
					nvim_lint.try_lint()
				end,
			})
		end,
	},

	----- git
	-- git indicators on the signcolumn
	{
		'lewis6991/gitsigns.nvim',
		version = '*',
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

	-- greatest plugin to ever exist :)
	{
		'tpope/vim-fugitive',
		tag = 'v3.7',
		cmd = { 'Git', 'Gwrite' },
	},
}

-- lazy.nvim options
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
			},
		},
	},
}

require('lazy').setup(plugins, opts)
