vim.opt.guicursor = ""

vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.errorbells = false

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.wrap = false

local mac = vim.fn.has('macunix')
local home = mac and "HOME" or "UserProfile"
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv(home) .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.incsearch = true
vim.opt.hlsearch = false

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"

vim.opt.cmdheight = 1

vim.opt.updatetime = 50

vim.opt.colorcolumn = "80"

vim.g.mapleader = " "

if mac == 0 then
    vim.g.android_sdk_path = "C:/Users/neilp/AppData/Local/Android/Sdk"
    vim.g.python3_host_prog = "C:/Python312/python"
end

vim.g.loaded_perl_provider = 0
vim.g.unrealnvim_debug = true
