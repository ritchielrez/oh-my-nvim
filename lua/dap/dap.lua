local dap_status_ok, dap = pcall(require, 'dap')
if not dap_status_ok then
	return
end

local opts = { noremap = true, silent = true }
local map = vim.keymap.set

-- Debugging keymaps
map('n', '<Leader>dt', ':lua require"dap".toggle_breakpoint()<CR>', opts)
map('n', '<Leader>db', ':lua require"dap".step_back()<CR>', opts)
map('n', '<Leader>dc', ':lua require"dap".continue()<CR>', opts)
map('n', '<Leader>dC', ':lua require"dap".run_to_cursor()<CR>', opts)
map('n', '<Leader>dd', ':lua require"dap".disconnect()<CR>', opts)
map('n', '<Leader>dg', ':lua require"dap".session()<CR>', opts)
map('n', '<Leader>di', ':lua require"dap".step_into()<CR>', opts)
map('n', '<Leader>du', ':lua require"dap".step_over()<CR>', opts)
map('n', '<Leader>do', ':lua require"dap".step_out()<CR>', opts)
map('n', '<Leader>dp', ':lua require"dap".pause()<CR>', opts)
map('n', '<Leader>dr', ':lua require"dap".repl.toggle()<CR>', opts)
map('n', '<Leader>ds', ':lua require"dap".continue()<CR>', opts)
map('n', '<Leader>dq', ':lua require"dap".close()<CR>', opts)
map('n', '<Leader>dU', ':lua require"dapui".toggle()<CR>', opts)
