local M = {}
local Remap = require("nelwarr.keymap")
local nnoremap = Remap.nnoremap
local inoremap = Remap.inoremap

M.capabilities = vim.lsp.protocol.make_client_capabilities()

local function lsp_keymaps()
    nnoremap("gd", function() vim.lsp.buf.definition() end)
    nnoremap("K", function() vim.lsp.buf.hover() end)
    inoremap("<C-h>", function() vim.lsp.buf.signature_help() end)
end

M.on_attach = function (client, bufnr)
    lsp_keymaps()
end

return M
