
vim.pack.add({ 'https://github.com/nvim-mini/mini.nvim' })
require("mini.basics").setup()


vim.cmd("let g:netrw_liststyle = 3")

local opt = vim.opt
local keymap = vim.keymap

opt.number = true
opt.relativenumber = true
opt.cursorline = true
opt.signcolumn = "yes"
opt.termguicolors = true
opt.background = "dark"

opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.autoindent = true

opt.wrap = true
opt.linebreak = true
opt.breakindent = false
opt.showbreak = "↪ "

opt.ignorecase = true
opt.smartcase = true

opt.clipboard = "unnamedplus"
opt.backspace = "indent,eol,start"
opt.swapfile = false

opt.splitright = true
opt.splitbelow = true
opt.splitkeep = "screen"     -- 🔥 FIXES YOUR ORIGINAL ISSUE
opt.equalalways = true      -- 🔥 prevents forced resizing
vim.g.mapleader = " "

-- Keymaps
keymap.set("i", "jk", "<ESC>", { desc = "Exit insert mode" })

keymap.set("n", "<leader>nh", ":nohl<CR>", { desc = "Clear highlights" })

-- numbers
keymap.set("n", "<leader>+", "<C-a>")
keymap.set("n", "<leader>-", "<C-x>")

-- splits
keymap.set("n", "<leader>sv", "<C-w>v")
keymap.set("n", "<leader>sh", "<C-w>s")
keymap.set("n", "<leader>se", "<C-w>=")
keymap.set("n", "<leader>sx", "<cmd>close<CR>")

-- 🔥 window navigation (FIXED)
keymap.set("n", "<C-h>", "<C-w>h")
keymap.set("n", "<C-l>", "<C-w>l")
keymap.set("n", "<C-j>", "<C-w>j")
keymap.set("n", "<C-k>", "<C-w>k")

-- tabs
keymap.set("n", "<leader>to", "<cmd>tabnew<CR>")
keymap.set("n", "<leader>tx", "<cmd>tabclose<CR>")
keymap.set("n", "<leader>tn", "<cmd>tabn<CR>")
keymap.set("n", "<leader>tp", "<cmd>tabp<CR>")
keymap.set("n", "<leader>tf", "<cmd>tabnew %<CR>")

-- insert fix
keymap.set("i", "<C-e>", "<Esc>la", { desc = "Exit pair" })
