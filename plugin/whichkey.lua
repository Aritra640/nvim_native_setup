-- Install plugin
vim.pack.add({
  { src = "https://github.com/folke/which-key.nvim" },
})

-- Init (runs immediately)
vim.o.timeout = true
vim.o.timeoutlen = 500

-- Setup
local ok, wk = pcall(require, "which-key")
if not ok then return end

wk.setup({})
