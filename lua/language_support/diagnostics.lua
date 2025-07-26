local icons = require('defaults.icons')

local signs = {
	{ name = 'DiagnosticSignError', text = icons.diagnostics.Error },
	{ name = 'DiagnosticSignWarn', text = icons.diagnostics.Warning },
	{ name = 'DiagnosticSignHint', text = icons.diagnostics.Hint },
	{ name = 'DiagnosticSignInfo', text = icons.diagnostics.Information },
}

for _, sign in ipairs(signs) do
	vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = '' })
end

local config = {
	virtual_lines = false,
	-- virtual_text = false,
	virtual_text = {
		-- spacing = 7,
		-- update_in_insert = false,
		-- severity_sort = true,
		-- prefix = "<-",
		prefix = ' ●',
		source = 'if_many', -- Or "always"
		-- format = function(diag)
		--   return diag.message .. "blah"
		-- end,
	},

	-- show signs
	signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = icons.diagnostics.Error,
      [vim.diagnostic.severity.WARN] = icons.diagnostics.Warning,
      [vim.diagnostic.severity.HINT] = icons.diagnostics.Hint,
      [vim.diagnostic.severity.INFO] = icons.diagnostics.Information,
    }
	},
	update_in_insert = true,
	underline = true,
	severity_sort = true,
	float = {
		focusable = true,
		style = 'minimal',
		border = 'none',
		-- border = {"▄","▄","▄","█","▀","▀","▀","█"},
		source = 'if_many', -- Or "always"
		header = '',
		prefix = '',
		-- width = 40,
	},
}

vim.diagnostic.config(config)
