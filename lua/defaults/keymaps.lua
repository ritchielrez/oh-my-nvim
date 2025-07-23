-- `opts` mean options
local opts = { noremap = true, silent = true }

local map = vim.keymap.set

-- Better window navigation
map('n', '<C-h>', '<C-w>h', opts)
map('n', '<C-j>', '<C-w>j', opts)
map('n', '<C-k>', '<C-w>k', opts)
map('n', '<C-l>', '<C-w>l', opts)

-- Don't want to freeze neovim
map('n', 'K', '<nop>', opts)

-- Don't want to get inside of ex mode
map('n', 'Q', '<nop>', opts)

-- Resize with arrows
map('n', '<Up>', ':resize -2<CR>', opts)
map('n', '<Down>', ':resize +2<CR>', opts)
map('n', '<Left>', ':vertical resize -2<CR>', opts)
map('n', '<Right>', ':vertical resize +2<CR>', opts)

map('n', '<Leader>e', ':Lf<CR>', opts)

-- Apply the currently changed config
map('n', '<Leader>r', ':luafile %<CR>', opts)

-- Telescope: fuzzy finder
map('n', '<Leader>fb', ':Telescope buffers<CR>', opts)
map('n', '<Leader>ff', ':FzfLua files<CR>', opts)
map('n', '<Leader>fo', ':Telescope oldfiles<CR>', opts)
map('n', '<Leader>fg', ':Telescope git_files<CR>', opts)
map('n', '<Leader>fs', ':FzfLua live_grep<CR>', opts)
map('n', '<Leader>fn', ':Telescope notify<CR>', opts)

-- Generic lsp keymaps
map('n', '<Leader>ls', ':LspStart<CR>', opts)
map('n', '<Leader>lx', ':LspStop<CR>', opts)

-- Formatter.nvim keymaps
map('n', '<Leader>lf', ':Format<CR>', opts)
map('v', '<Leader>lf', ':Format<CR>', opts)

-- Command corrections
map('c', 'W', 'w', {})
map('c', 'Wq', 'wq', {})
map('c', 'WQ', 'wq', {})
map('c', 'Q', 'q', {})
map('c', 'Q!', 'q!', {})
map('c', 'Qa!', 'qa!', {})
map('c', 'QA!', 'qa!', {})

-- Git related keymaps
map({ 'n', 'v' }, '<Leader>gb', ':Gitsigns toggle_current_line_blame<CR>', opts)
map({ 'n', 'v' }, '<Leader>ghs', ':Gitsigns stage_hunk<CR>', opts)
map({ 'n', 'v' }, '<Leader>ghr', ':Gitsigns reset_hunk<CR>', opts)
map('n', '<Leader>gc', ':Git commit<CR>', opts)
map('n', '<Leader>gp', ':Git! push<CR>', opts)
map('n', '<Leader>gw', ':Gwrite<CR>', opts)

-- Diagnostics
map('n', 'gl', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
map('n', '[d', '<cmd>lua vim.diagnostic.goto_prev({ border = "rounded" })<CR>', opts)
map('n', ']d', '<cmd>lua vim.diagnostic.goto_next({ border = "rounded" })<CR>', opts)
map('n', '<leader>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)

-- Quickfix
map('n', '<leader>co', ':copen<CR>', opts)
map('n', '<leader>cx', ':cclose<CR>', opts)
map('n', '[e', ':cn<CR>', opts)
map('n', ']e', ':cp<CR>', opts)

-- Splits
map('n', '<leader>v', ':vs<CR><C-w>l', opts)
map('n', '<leader>s', ':sp<CR><C-w>k', opts)

-- Terminal keymaps
map('t', '<Esc>', '<C-\\><C-n>', opts)
