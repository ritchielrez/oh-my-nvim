-- `opts` mean options
local opts = { noremap = true, silent = true }

local map = vim.keymap.set

-- Better window navigation
map('n', '<C-h>', '<C-w>h', opts)
map('n', '<C-j>', '<C-w>j', opts)
map('n', '<C-k>', '<C-w>k', opts)
map('n', '<C-l>', '<C-w>l', opts)

-- Don't want to get inside of ex mode
map('n', 'Q', '<nop>', opts)

-- Resize with arrows
map('n', '<Up>', ':resize -2<CR>', opts)
map('n', '<Down>', ':resize +2<CR>', opts)
map('n', '<Left>', ':vertical resize -2<CR>', opts)
map('n', '<Right>', ':vertical resize +2<CR>', opts)

map('n', '<Leader>e', ':20Lex<CR>', opts)

-- Apply the currently changed config
map('n', '<Leader>so', ':luafile %<CR>', opts)

-- Telescope: fuzzy finder
map('n', '<Leader>ff', ':Telescope find_files<CR>', opts)
map('n', '<Leader>fo', ':Telescope oldfiles<CR>', opts)

-- Generic lsp keymaps
map('n', '<Leader>ls', ':LspStart<CR>', opts)
map('n', '<Leader>lx', ':LspStop<CR>', opts)

vim.cmd([[ command! Format execute 'lua vim.lsp.buf.formatting()' ]])
map('n', '<Leader>lf', ':Format<CR>', opts)

-- Terminal keymaps
map('t', '<Esc>', '<C-\\><C-n>', {})
map('n', '<C-\\>', ':term<CR>', {})
