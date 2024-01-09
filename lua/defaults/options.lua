local set = vim.opt
local let = vim.g

-- use :help to know about these options

set.number = true
set.relativenumber = true

set.linespace = 0

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

set.wrap = false

set.lazyredraw = true

set.fsync = false

set.list = false
-- set.listchars = 'trail:·,nbsp:◇,tab:→ ,extends:▸,precedes:◂'

set.clipboard = 'unnamedplus'

let.mapleader = ' '

-- netrw
let.netrw_banner = 0
let.netrw_liststyle = 3

-- Highlight the region on yank
vim.api.nvim_create_autocmd('TextYankPost', {
	group = num_au,
	callback = function()
		vim.highlight.on_yank({ higroup = 'Visual', timeout = 150 })
	end,
})

-- vim.o.shell = 'bash'
-- vim.o.shellcmdflag = '-s'
vim.o.guifont = 'FiraCode Nerd Font:h12'

vim.g.neovide_padding_top = 20
vim.g.neovide_padding_bottom = 20
vim.g.neovide_padding_right = 20
vim.g.neovide_padding_left = 20

vim.g.neovide_unlink_border_highlights = true
