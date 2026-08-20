local overseer = require('overseer')
overseer.setup()

overseer.add_template_hook({
	module = '^cargo$',
}, function(task_defn, util)
	-- The `util` parameter is just a namespace that exposes some useful functions
	-- for mutating a task definition
	util.add_component(task_defn, {
		{ 'on_output_quickfix', set_diagnostics = true },
		'on_result_diagnostics',
		'default',
	})
	util.remove_component(task_defn, 'on_complete_dispose')
end)

vim.api.nvim_create_user_command('OverseerRerun', function()
	local task_list = require('overseer.task_list')
	local tasks = overseer.list_tasks({
		status = {
			overseer.STATUS.SUCCESS,
			overseer.STATUS.FAILURE,
			overseer.STATUS.CANCELED,
		},
		sort = task_list.sort_finished_recently,
	})
	if vim.tbl_isempty(tasks) then
		vim.cmd('OverseerRun')
	else
		local most_recent = tasks[1]
		overseer.run_action(most_recent, 'restart')
	end
end, {})
