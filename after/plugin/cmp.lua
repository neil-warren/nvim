local cmp = require 'cmp'

cmp.setup({
    snippet = {
        expand = function (args)
            require('luasnip').lsp_expand(args.body)
        end
    },
    window = {
        completion = cmp.config.window.bordered(),
    },
	mapping = cmp.mapping.preset.insert({
		['<C-b>'] = cmp.mapping.scroll_docs(-4),
		['<C-f>'] = cmp.mapping.scroll_docs(4),
		['<C-Space>'] = cmp.mapping.complete(),
		['<C-e>'] = cmp.mapping.abort(),
		['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
	}),
    sources = cmp.config.sources({
        -- { name = 'ultisnips'}, -- For ultisnips users.
        { name = 'nvim_lsp'},
        -- { name = 'vsnip' }, -- For vsnip users.
        { name = 'luasnip' }, -- For luasnip users.
        -- { name = 'snippy' }, -- For snippy users.
    }, {
        { name = 'buffer'},
    })
})

cmp.setup.cmdline('/', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
        { name = 'buffer' }
    }
})

cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
        { name = 'path' }
    }, {
        {
            name = 'cmdline',
            option = {
                ignore_cmds = { 'Man', '!' }
            }
        }
    })
})

local capabilities = require('cmp_nvim_lsp').default_capabilities()

local clangConf = require('lspconfig')['clangd']
clangConf.setup {
    capabilities = capabilities,
}

require('lspconfig')['lua_ls'].setup {
    capabilities = capabilities
}
require('lspconfig')['kotlin_language_server'].setup{}
require('lspconfig')['pyright'].setup{}
require('lspconfig')['cssls'].setup{}
require('lspconfig')['htmx'].setup{}
require('lspconfig')['html'].setup{
    filetypes = { "html", "htmldjango" },
}

