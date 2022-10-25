local dap = require('dap')

local mason_path = vim.fn.glob(vim.fn.stdpath "data" .. "/mason/")

dap.adapters.cppdbg = {
  id = 'cppdbg',
  type = 'executable',
  command = mason_path .. 'packages/cpptools/extension/debugAdapters/bin/OpenDebugAD7.exe',
  options = {
    detached = false
  }
}

dap.configurations.cpp = {
  {
    name = "Launch file",
    type = "cppdbg",
    request = "launch",
    program = function()
      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    end,
    cwd = '${workspaceFolder}',
    stopAtEntry = true,
  }
}
