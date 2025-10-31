require("nelwarr.set")
require("nelwarr.remap")
require("nelwarr.lazy_init")
--require("nelwarr.packer")

local augroup = vim.api.nvim_create_augroup
local NelwarrGroup = augroup("Nelwarr", {})
local yank_group = augroup("HighlightYank", {})
local color_group = augroup("ApplyColor", { clear = true})

local autocmd = vim.api.nvim_create_autocmd

local opts = { noremap = true, silent = true }
local keymap = vim.keymap

autocmd("TextYankPost", {
    group = yank_group,
    pattern = "*",
    callback = function()
        vim.highlight.on_yank({
            higroup = "IncSearch",
            timeout = 40,
        })
    end,
})

autocmd("VimEnter", {
    group = color_group,
    callback = function()
        -- Apply the colorscheme only once Neovim is fully initialized
        vim.cmd.colorscheme("rose-pine")

        -- Re-apply your custom transparency overrides *after* the theme is set.
        -- This is the only way to ensure they take precedence.
        vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
        vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
        vim.api.nvim_set_hl(0, "NormalNC", { bg = "none" })
        vim.api.nvim_set_hl(0, "FloatBorder", { bg = "none" })
        vim.api.nvim_set_hl(0, "CursorLine", { bg = "none" })

        -- You may want to comment out the line above if you want
        -- rose-pine's intended CursorLine color.
    end,
})

autocmd('LspAttach', {
    group = NelwarrGroup,
    callback = function(e)
        opts.buffer = e.buf
        --vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
        --vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
        --vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
        --vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
        --vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
        --vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
        --vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
        --vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
        --vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
        --vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
        -- set keybinds
        opts.desc = "Show LSP references"
        keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", opts) -- show definition, references

        opts.desc = "Go to declaration"
        keymap.set("n", "gD", vim.lsp.buf.declaration, opts) -- go to declaration

        opts.desc = "Show LSP definitions"
        keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts) -- show lsp definitions

        opts.desc = "Show LSP implementations"
        keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts) -- show lsp implementations

        opts.desc = "Show LSP type definitions"
        keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts) -- show lsp type definitions

        opts.desc = "See available code actions"
        keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts) -- see available code actions, in visual mode will apply to selection

        opts.desc = "Smart rename"
        keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts) -- smart rename

        opts.desc = "Show buffer diagnostics"
        keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts) -- show  diagnostics for file

        opts.desc = "Show line diagnostics"
        keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts) -- show diagnostics for line

        opts.desc = "Go to previous diagnostic"
        keymap.set("n", "[d", vim.diagnostic.goto_prev, opts) -- jump to previous diagnostic in buffer

        opts.desc = "Go to next diagnostic"
        keymap.set("n", "]d", vim.diagnostic.goto_next, opts) -- jump to next diagnostic in buffer

        opts.desc = "Show documentation for what is under cursor"
        keymap.set("n", "K", vim.lsp.buf.hover, opts) -- show documentation for what is under cursor

        opts.desc = "Restart LSP"
        keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts) -- mapping to restart lsp if necessary
    end
})

vim.g.matchparen_timeout = 2
vim.g.matchparen_insert_timeout = 2
vim.g.netrw_browse_split = 0
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 25
