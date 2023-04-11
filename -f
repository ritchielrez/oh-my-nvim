local pretty_hover_status_ok, pretty_hover = pcall(require, 'pretty_hover')
if not pretty_hover_status_ok then
    print('Pretty_hover plugin not installed')
end
pretty_hover.setup({
    line = {
        '@brief',
    },
    word = {
        '@param',
        '@tparam',
        '@see',
    },
    header = {
        '@class',
    },
    stylers = {
        line = '**',
        word = '`',
        header = '###',
    },
    border = 'rounded',
})
