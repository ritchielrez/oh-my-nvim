local set = vim.opt
local let = vim.g

-- use :help to know about these options

set.number = true

set.tabstop = 2
set.softtabstop = 2
set.shiftwidth = 2
set.expandtab = true
set.hlsearch = false
set.incsearch = true

set.swapfile = false
set.backup = false

set.signcolumn = 'yes'
set.numberwidth = 4

set.backup = false
set.writebackup = false

set.hidden = true

set.updatetime = 300

set.laststatus = 3

set.smartindent = true

set.wrap = true

set.lazyredraw = true

set.list = true
set.listchars = 'trail:·,nbsp:◇,tab:→ ,extends:▸,precedes:◂'

set.clipboard = 'unnamedplus'

let.mapleader = ' '

-- Highlight the region on yank
vim.api.nvim_create_autocmd('TextYankPost', {
	group = num_au,
	callback = function()
		vim.highlight.on_yank({ higroup = 'Visual', timeout = 150 })
	end,
})
