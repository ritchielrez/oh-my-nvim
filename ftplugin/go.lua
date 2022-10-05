local dap_go_ok, dap_go = pcall(require, "dap-go")
if not dap_go_ok then
  return
end

dap_go.setup()

-- Extra debugging keymap for go
local opts = { noremap = true, silent = true }

local map = vim.keymap.set

map('n', '<Leader>dT', ':lua require"dap-go".debug_test()<CR>', opts)
