local opts = { noremap = true, silent = true }

local map = vim.keymap.set

map('n', '<Leader>dt', ':call vimspector#ToggleBreakpoint()<CR>', opts)
map('n', '<Leader>dc', ':call vimspector#Continue()<CR>', opts)
map('n', '<Leader>dC', ':call vimspector#RunToCursor()<CR>', opts)
map('n', '<Leader>di', ':call vimspector#StepInto()<CR>', opts)
map('n', '<Leader>du', ':call vimspector#StepOver()<CR>', opts)
map('n', '<Leader>do', ':call vimspector#StepOut()<CR>', opts)
map('n', '<Leader>dp', ':call vimspector#Pause()<CR>', opts)
map('n', '<Leader>dq', ':call vimspector#Stop()<CR>', opts)
map('n', '<Leader>dU', ':VimspectorReset<CR>', opts)
