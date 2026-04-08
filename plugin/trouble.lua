-- Install plugins via vim.pack
vim.pack.add({
  { src = "https://github.com/folke/trouble.nvim" },
  { src = "https://github.com/nvim-tree/nvim-web-devicons" },
  { src = "https://github.com/folke/todo-comments.nvim" },
})

-- Setup after load
vim.defer_fn(function()
  -- Setup trouble.nvim
  local ok_trouble, trouble = pcall(require, "trouble")
  if ok_trouble then
    trouble.setup({
      focus = true,
    })
  end

  -- Setup todo-comments.nvim
  local ok_todo, todo = pcall(require, "todo-comments")
  if ok_todo then
    todo.setup()
  end

  -- Optional but recommended: cleaner diagnostics UI
  vim.diagnostic.config({
    virtual_text = false,
  })
end, 0)

-- Keymaps
vim.keymap.set("n", "<leader>xw", "<cmd>Trouble diagnostics toggle<CR>", {
  desc = "Workspace diagnostics (Trouble)",
})

vim.keymap.set("n", "<leader>xd", "<cmd>Trouble diagnostics toggle filter.buf=0<CR>", {
  desc = "Document diagnostics (Trouble)",
})

vim.keymap.set("n", "<leader>xq", "<cmd>Trouble quickfix toggle<CR>", {
  desc = "Quickfix list (Trouble)",
})

vim.keymap.set("n", "<leader>xl", "<cmd>Trouble loclist toggle<CR>", {
  desc = "Location list (Trouble)",
})

vim.keymap.set("n", "<leader>xt", "<cmd>Trouble todo toggle<CR>", {
  desc = "TODOs (Trouble)",
})
