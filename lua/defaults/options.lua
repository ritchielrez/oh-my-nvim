local set = vim.opt
local let = vim.g

-- use :help to know about these options

set.number = true

set.tabstop = 4
set.softtabstop = 4
set.shiftwidth = 4
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

set.fsync = false

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

-- vim.o.shell = 'bash'
-- vim.o.shellcmdflag = '-s'
vim.o.guifont = 'CaskaydiaCove Nerd Font:h12'
