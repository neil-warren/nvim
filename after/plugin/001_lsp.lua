local lsp = require("lsp-zero")
lsp.extend_lspconfig()

require('mason').setup()
--require('mason-lspconfig').setup()
require('mason-lspconfig').setup({
    ensure_installed = {
        "lua_ls", "clangd"
    },
    handlers = {
        lsp.default_setup,
    },
})


lsp.configure('lua_ls', {
    on_new_config = function(config, new_root_dir)
        local is_wow_project = vim.fn.glob(new_root_dir .. '/.pkgmeta') ~= "" or vim.fn.glob(new_root_dir .. '/*.toc') ~= ""
        local is_weakaura_project = vim.fn.glob(new_root_dir .. '/.wacheck') ~= ""
        config.settings.Lua.runtime.version = (is_wow_project or is_weakaura_project) and 'Lua 5.1' or 'LuaJIT'
        config.settings.Lua.diagnostics.globals = (is_wow_project or is_weakaura_project)and {} or {'vim'}
        config.settings.Lua.workspace.library = is_wow_project and {"~/vscode-wow-api/EmmyLua/"} or vim.api.nvim_get_runtime_file("", true)
        config.settings.Lua.workspace.preloadFileSize = (is_wow_project or is_weakaura_project)and 1000 or 100
        if is_wow_project then
            config.settings.Lua.workspace.library = {"~/vscode-wow-api/EmmyLua/"}
        elseif is_weakaura_project then
            config.settings.Lua.workspace.library = {
                "C:/Program Files/Battle.net/World of Warcraft/_retail_/Interface/AddOns/WeakAuras",
                "~/vscode-wow-api/EmmyLua/",
                "~/Documents/Notes/WoW/WeakAuras/initAuras.lua"
            }
        else
            vim.api.nvim_get_runtime_file("", true)
        end
    end;
    settings = {
        Lua = {
            runtime = {
                path = runtime_path,
            },
            diagnostics = {
                globals = { "vim" },
            },
            workspace = {},
            telemetry = {
                enable = false,
            },
        },
    },
})

local cmp = require("cmp")
local cmp_select = {behavior = cmp.SelectBehavior.Select}
local cmp_mappings = lsp.defaults.cmp_mappings({
    ["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
    ["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
    ["<C-y>"] = cmp.mapping.confirm({ select = true}),
    ["<C-Space>"] = cmp.mapping.complete(),
})

lsp.set_preferences({
    suggest_lsp_serverse = false,
    sign_icons = {
        error = "E",
        warn = "W",
        hint = "H",
        info = "I",
    }
})

lsp.on_attach(function(client, bufnr)
    local opts = {buffer = bufnr, remap = false}

    vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
    vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
    vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
    vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
    vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
    vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
    vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
    vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
    vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
    vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
end)

vim.keymap.set("n", "<M-o>", function()
    local filename = vim.fn.expand('%:p')
    local new_filename

    if string.match(filename, '.h$') then
        new_filename = string.gsub(filename, '.h$', '.cpp')
    elseif string.match(filename, '.cpp$') then
        new_filename = string.gsub(filename, '.cpp$', '.h')
    end

    if new_filename then
        vim.cmd('e ' .. new_filename)
    end
end, opts)

vim.diagnostic.config({
    virtual_text = true
})
