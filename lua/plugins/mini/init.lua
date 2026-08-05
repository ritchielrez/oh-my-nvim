require('mini.comment').setup()
require('mini.icons').setup()
require('mini.pairs').setup()

local MiniFiles = require('mini.files')

-- Set focused directory as current working directory
local set_cwd = function()
	local path = (MiniFiles.get_fs_entry() or {}).path
	if path == nil then
		return vim.notify('Cursor is not on valid entry')
	else
		return vim.notify('Directory changed to ' .. path)
	end
	vim.fn.chdir(vim.fs.dirname(path))
end

-- Yank in register full path of entry under cursor
local yank_path = function()
	local path = (MiniFiles.get_fs_entry() or {}).path
	if path == nil then
		return vim.notify('Cursor is not on valid entry')
	end
	vim.fn.setreg(vim.v.register, path)
end

-- Open path with system default handler (useful for non-text files)
local ui_open = function()
	vim.ui.open(MiniFiles.get_fs_entry().path)
end

vim.api.nvim_create_autocmd('User', {
	pattern = 'MiniFilesBufferCreate',
	callback = function(args)
		local b = args.data.buf_id
		vim.keymap.set('n', '-', set_cwd, { buffer = b, desc = 'Set cwd' })
		vim.keymap.set('n', 'gX', ui_open, { buffer = b, desc = 'OS open' })
		vim.keymap.set('n', 'gy', yank_path, { buffer = b, desc = 'Yank path' })
	end,
})

MiniFiles.setup()
