vim.keymap.set("n", "<C-b>", "<cmd>UnrealBuild<CR>")
vim.keymap.set("n", "<F5>", "<cmd>UnrealRun<CR>")
vim.keymap.set("n", "<leader>c", "<C-M-F11>")

local lualine = require("lualine")
local UnrealCommands = require('Unreal.commands')
UnrealCommands.onStatusUpdate = function()
    lualine.refresh()
end
