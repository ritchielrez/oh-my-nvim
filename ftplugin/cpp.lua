local dap_ok, dap = pcall(require, 'dap')
if not dap_ok then
	return
end

local mason_path = vim.fn.glob(vim.fn.stdpath('data') .. '/mason/')

dap.adapters.codelldb = {
	type = 'server',
	port = '${port}',
	executable = {
		-- CHANGE THIS to your path!
		command = mason_path .. 'packages/codelldb/extension/adapter/codelldb',
		args = { '--port', '${port}' },

		-- On windows you may have to uncomment this:
		detached = false,
	},
}

dap.configurations.cpp = {
	{
		name = 'Launch file',
		type = 'codelldb',
		request = 'launch',
		program = function()
			return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
		end,
		cwd = '${workspaceFolder}',
		stopOnEntry = false,
	},
}
