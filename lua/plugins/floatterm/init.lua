local M = {}
-- Table to keep terminal state
M.float_term = {
	buf = nil,
	win = nil,
}

function M.toggle()
	if M.float_term.win and vim.api.nvim_win_is_valid(M.float_term.win) then
		-- Close the floating window
		vim.api.nvim_win_close(M.float_term.win, true)
		M.float_term.win = nil
		return
	end

	if not M.float_term.buf or not vim.api.nvim_buf_is_valid(M.float_term.buf) then
		-- Create a new terminal buffer
		M.float_term.buf = vim.api.nvim_create_buf(false, true) -- [listed=false, scratch=true]
		vim.api.nvim_buf_set_option(M.float_term.buf, 'bufhidden', 'hide')

		-- Start terminal job
		-- vim.fn.termopen(os.getenv('SHELL') or 'bash')
		vim.api.nvim_buf_call(M.float_term.buf, function()
			vim.fn.termopen('bash')
			vim.cmd('startinsert')
		end)
	end

	-- Calculate floating window size and position
	local width = math.floor(vim.o.columns * 0.8)
	local height = math.floor(vim.o.lines * 0.8)
	local row = math.floor((vim.o.lines - height) / 2)
	local col = math.floor((vim.o.columns - width) / 2)

	-- Open the floating window
	M.float_term.win = vim.api.nvim_open_win(M.float_term.buf, true, {
		relative = 'editor',
		width = width,
		height = height,
		row = row,
		col = col,
		style = 'minimal',
		border = 'rounded',
	})
end

vim.api.nvim_create_user_command('FloatTerm', function()
	M.toggle()
end, { desc = 'Toggle a floating terminal' })

return M
