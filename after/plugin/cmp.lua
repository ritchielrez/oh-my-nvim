local cmp_status_ok, cmp = pcall(require, 'cmp')
if not cmp_status_ok then
	print('Nvim-cmp plugin not installed')
end

local snip_status_ok, luasnip = pcall(require, 'luasnip')
if not snip_status_ok then
	print('Luasnip plugin not installed')
end

local lspkind_status_ok, lspkind = pcall(require, 'lspkind')
if not lspkind_status_ok then
    print('Lspkind plugin not installed')
end

cmp.setup({
	window = {
		completion = {
			scrollbar = false,
		},
	},
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end,
	},
    formatting = {
        format = lspkind.cmp_format({
            mode = 'symbol',
            maxwidth = 100,
            ellipsis_char = '...',
            symbol_map = require('defaults.icons').kind,
        })
    },
	mapping = cmp.mapping.preset.insert({
		['<C-b>'] = cmp.mapping.scroll_docs(-4),
		['<C-f>'] = cmp.mapping.scroll_docs(4),
		['<C-Space>'] = cmp.mapping.complete(),
		['<C-e>'] = cmp.mapping.abort(),
		['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
		['<Tab>'] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			elseif luasnip.jumpable(1) then
				luasnip.jump(1)
			elseif luasnip.expand_or_jumpable() then
				luasnip.expand_or_jump()
			elseif luasnip.expandable() then
				luasnip.expand()
			else
				fallback()
			end
		end, {
			'i',
			's',
		}),
		['<S-Tab>'] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			elseif luasnip.jumpable(-1) then
				luasnip.jump(-1)
			else
				fallback()
			end
		end, {
			'i',
			's',
		}),
	}),
	sources = cmp.config.sources({
		{ name = 'nvim_lsp' },
		{ name = 'nvim_lua' },
		{ name = 'path' },
		{ name = 'luasnip' },
		{ name = 'buffer' },
		{ name = 'nvim_lsp_signature_help' },
	}),
	experimental = {
		ghost_text = true,
	},
})
