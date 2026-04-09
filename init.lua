vim.opt.splitright = true
vim.opt.splitbelow = true

-- window management 
vim.keymap.set("n", "<leader>sh", "<C-w>s", {desc = "split horizonatally"})
vim.keymap.set("n", "<leader>sv", "<C-w>v", {desc = "split vertically"})
vim.keymap.set("n", "<leader>se", "<C-w>=", {desc = "make splits equal"})
vim.keymap.set("n", "<leader>sc", "<cmd>close<CR>", {desc = "close current split"})


-- tab management 
vim.keymap.set("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "Open new tab" }) -- open new tab
vim.keymap.set("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "Close current tab" }) -- close current tab
vim.keymap.set("n", "<leader>tn", "<cmd>tabn<CR>", { desc = "Go to next tab" }) --  go to next tab
vim.keymap.set("n", "<leader>tp", "<cmd>tabp<CR>", { desc = "Go to previous tab" }) --  go to previous tab
vim.keymap.set("n", "<leader>tf", "<cmd>tabnew %<CR>", { desc = "Open current buffer in new tab" }) --  move current buffer to new tab
vim.keymap.set("i","C-e","ESC-l-a",{desc = "Get out of current parenthesis or quotation"})



vim.opt.wrap = true
vim.opt.linebreak = true
vim.opt.breakindent = true
