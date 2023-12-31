local formatter_ok, formatter = pcall(require, 'formatter')
if not formatter_ok then
	print('Formatter.nvim plugin not installed')
end

formatter.setup({
	-- Enable or disable logging
	logging = true,
	-- Set the log level
	log_level = vim.log.levels.WARN,
	-- All formatter configurations are opt-in
	filetype = {
		-- Formatter configurations for filetype "lua" go here
		-- and will be executed in order
		c = {
			require('formatter.filetypes.c').clangformat,
		},
		cpp = {
			require('formatter.filetypes.cpp').clangformat,
		},
		go = {
			require('formatter.filetypes.go').golines,
		},
		lua = {
			-- -- "formatter.filetypes.lua" defines default configurations for the
			-- -- "lua" filetype
			-- function()
			-- 	-- Supports conditional formatting
			-- 	-- if util.get_current_buffer_file_name() == 'special.lua' then
			-- 	-- 	return nil
			-- 	-- end
			--
			-- 	-- Full specification of configurations is down below and in Vim help
			-- 	-- files
			-- 	return {
			-- 		exe = 'stylua',
			-- 		args = {},
			-- 		stdin = false,
			-- 	}
			-- end,
			require('formatter.filetypes.lua').stylua,
		},

		-- Use the special "*" filetype for defining formatter configurations on
		-- any filetype
		['*'] = {
			-- "formatter.filetypes.any" defines default configurations for any
			-- filetype
			require('formatter.filetypes.any').remove_trailing_whitespace,
		},
	},
})
