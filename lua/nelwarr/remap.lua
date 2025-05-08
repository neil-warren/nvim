vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<leader>dt", "i{% %}<C-c>F i ")
vim.keymap.set("n", "<leader>db", "i{{ }}<C-c>F i ")
vim.keymap.set("n", "<C-d", "<C-d>zz")
vim.keymap.set("n", "<C-u", "<C-u>zz")
vim.keymap.set("n", "<leader>q", "<C-w>q")
vim.keymap.set("n", "<leader>o", "<C-w>o")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")
vim.keymap.set("n", "<leader>cp", "\"*p")
vim.keymap.set("v", "<leader>cy", "\"*y")

vim.keymap.set("x", "<leader>p", [["_dP]])

vim.keymap.set("i", "<C-c>", "<Esc>")


vim.keymap.set("n", "<leader><leader>", function()
    vim.cmd("so")
end)

vim.keymap.set("n", "<leader>h", function()
    if vim.opt.hlsearch:get() and vim.v.hlsearch then
        vim.opt.hlsearch = false
    else
        vim.opt.hlsearch = true
    end
end)
