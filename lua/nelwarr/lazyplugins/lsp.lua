return {
    "neovim/nvim-lspconfig",
    dependencies = {
        -- LSP Support
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",

        -- Autocompletion
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-cmdline",
        "hrsh7th/nvim-cmp",

        -- Snippets
        "L3MON4D3/LuaSnip",
        "saadparwaiz1/cmp_luasnip",

        -- Linting
        'mfussenegger/nvim-lint',

        -- Autoindent
        'Vimjas/vim-python-pep8-indent',
    },

    config = function()
        local lsp = vim.lsp
        local cmp = require('cmp')
        local cmp_lsp = require("cmp_nvim_lsp")
        local capabilities = cmp_lsp.default_capabilities()

        require("mason").setup()
        require("mason-lspconfig").setup({
            ensure_installed = {
                "lua_ls", "clangd",
                "pyright", "html", "cssls", "htmx", "tailwindcss",
            },
        })
        -- configure Swift serve here since it is not installed via Mason
        lsp.config("sourcekit", {
            -- capabilities = capabilities,
            capabilities = capabilities,
            cmd = { vim.trim(vim.fn.system("xcrun -f sourcekit-lsp")) },
            on_attach = function (client, bufnr)
                client.server_capabilities.semanticTokensProvider = nil
            end,
            --args = {
            --    '-Xswiftc', '-sdk',
            --    '-Xswiftc', '/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneSimulator.platform/Developer/SDKs/iPhoneSimulator.sdk',
            --    -- Or, for a specific iOS version:
            --    -- '-Xswiftc', '/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS17.0.sdk',
            --    '-Xswiftc', '-target',
            --    '-Xswiftc', 'arm64-apple-ios13.0-simulator', -- Adjust target as needed (e.g., ios17.0)
            --    '-Xcc', '-DSWIFT_PACKAGE=0' -- May be required for certain project types
            --},
            on_init = function(client)
                -- HACK: to fix some issues with LSP
                -- more details: https://github.com/neovim/neovim/issues/19237#issuecomment-2237037154
                client.offset_encoding = "utf-8"
            end,
        })
        lsp.enable({"sourcekit"})


        local cmp_select = { behavior = cmp.SelectBehavior.Select }

        cmp.setup({
            snippet = {
                expand = function(args)
                    require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
                end,
            },
            mapping = cmp.mapping.preset.insert({
                ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
                ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
                ['<CR>'] = cmp.mapping.confirm({ select = true }),
                ["<C-Space>"] = cmp.mapping.complete(),
            }),
            sources = cmp.config.sources({
                { name = 'nvim_lsp' },
                { name = 'luasnip' }, -- For luasnip users.
                { name = 'buffer' },
            })
        })

        cmp.setup.cmdline({ '/', '?' }, {
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

        vim.diagnostic.config({
            -- update_in_insert = true,
            float = {
                focusable = false,
                style = "minimal",
                border = "rounded",
                source = "always",
                header = "",
                prefix = "",
            },
        })
    end
}
