return {
	name = 'go run .',
	builder = function()
		return {
			cmd = { 'go', 'run', '.' },
			-- attach a component to the task that will pipe the output to the quickfix.
			-- components customize the behavior of a task.
			-- see :help overseer-components for a list of all components.
			components = {
				{ 'on_output_quickfix', set_diagnostics = true },
				'on_result_diagnostics',
				'default',
			},
		}
	end,
	condition = {
		filetype = { 'go', 'gomod', 'godoc' },
	},
}
