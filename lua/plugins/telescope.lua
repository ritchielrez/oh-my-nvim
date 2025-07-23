local telescope_ok, telescope = pcall(require, 'telescope')
if not telescope_ok then
	print('Telescope plugin not installed')
end

local actions = require('telescope.actions')

telescope.setup({
	defaults = {
		prompt_prefix = require('defaults.icons').ui.Telescope .. ' ',
		sorting_strategy = 'ascending',
		selection_caret = ' ',
		path_display = { 'truncate' },
		border = {},
		borderchars = { '', '', '', '', '', '', '', '' },
		file_ignore_patterns = { '.git' },
		layout_config = {
			prompt_position = 'top',
		},
		mappings = {
			i = {
				['<Esc>'] = actions.close,
				['<C-n>'] = actions.cycle_history_next,
				['<C-p>'] = actions.cycle_history_prev,
				['<C-j>'] = actions.move_selection_next,
				['<C-k>'] = actions.move_selection_previous,
				['<C-c>'] = actions.close,
				['<Down>'] = actions.move_selection_next,
				['<Up>'] = actions.move_selection_previous,
				['<CR>'] = actions.select_default,
				['<C-x>'] = actions.select_horizontal,
				['<C-v>'] = actions.select_vertical,
				['<C-t>'] = actions.select_tab,
				['<C-u>'] = actions.preview_scrolling_up,
				['<C-d>'] = actions.preview_scrolling_down,
				['<PageUp>'] = actions.results_scrolling_up,
				['<PageDown>'] = actions.results_scrolling_down,
				['<Tab>'] = actions.toggle_selection + actions.move_selection_worse,
				['<S-Tab>'] = actions.toggle_selection + actions.move_selection_better,
				['<C-q>'] = actions.send_to_qflist + actions.open_qflist,
				['<M-q>'] = actions.send_selected_to_qflist + actions.open_qflist,
				['<C-l>'] = actions.complete_tag,
				['<C-_>'] = actions.which_key, -- keys from pressing <C-/>
			},
			n = {
				['<esc>'] = actions.close,
				['<CR>'] = actions.select_default,
				['<C-x>'] = actions.select_horizontal,
				['<C-v>'] = actions.select_vertical,
				['<C-t>'] = actions.select_tab,
				['<Tab>'] = actions.toggle_selection + actions.move_selection_worse,
				['<S-Tab>'] = actions.toggle_selection + actions.move_selection_better,
				['<C-q>'] = actions.send_to_qflist + actions.open_qflist,
				['<M-q>'] = actions.send_selected_to_qflist + actions.open_qflist,
				['j'] = actions.move_selection_next,
				['k'] = actions.move_selection_previous,
				['H'] = actions.move_to_top,
				['M'] = actions.move_to_middle,
				['L'] = actions.move_to_bottom,
				['<Down>'] = actions.move_selection_next,
				['<Up>'] = actions.move_selection_previous,
				['gg'] = actions.move_to_top,
				['G'] = actions.move_to_bottom,
				['<C-u>'] = actions.preview_scrolling_up,
				['<C-d>'] = actions.preview_scrolling_down,
				['<PageUp>'] = actions.results_scrolling_up,
				['<PageDown>'] = actions.results_scrolling_down,
				['?'] = actions.which_key,
			},
		},
	},
	extensions = {
		['ui-select'] = {
			require('telescope.themes').get_dropdown(),
		},

		fzf = {
			fuzzy = true, -- false will only do exact matching
			override_generic_sorter = true, -- override the generic sorter
			override_file_sorter = true, -- override the file sorter
			case_mode = 'smart_case', -- or "ignore_case" or "respect_case"
			-- the default case_mode is "smart_case"
		},
	},
	pickers = {
		find_files = { previewer = false },
		oldfiles = { previewer = false },
		git_files = { previewer = false },
		live_grep = { previewer = true},
	},
})
telescope.load_extension('ui-select')
telescope.load_extension('fzf')

vim.api.nvim_set_hl(0, 'TelescopeSelection', { bg = 'none' })
vim.api.nvim_set_hl(0, 'TelescopeSelectionCaret', { link = 'Orange' })
