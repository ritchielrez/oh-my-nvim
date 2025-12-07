return {
	cmd = { 'vscode-css-language-server', '--stdio' },
	filetypes = { 'css', 'less', 'scss' },
	root_markers = { 'package.json', '.git' },
	init_options = {
		provideFormatter = false,
	},
	settings = {
		css = { validate = true },
		less = css,
		scss = css,
	},
}
