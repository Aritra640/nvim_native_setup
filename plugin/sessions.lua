require('mini.sessions').setup({
  autoread = false,
  autowrite = false,
  file = "Session.vim",

  force = { read = true, write = true, delete = true},

  verbose = { read = false, write = false, delete = true},
}) 

-- Save session
vim.keymap.set("n", "<leader>zs", function()
  require("mini.sessions").write()
end, { desc = "Save session" })

-- Load session (interactive picker)
vim.keymap.set("n", "<leader>zl", function()
  require("mini.sessions").select()
end, { desc = "Load session" })

-- Delete session
vim.keymap.set("n", "<leader>zd", function()
  require("mini.sessions").select("delete")
end, { desc = "Delete session" })

-- Name sessions
vim.keymap.set("n", "<leader>z", function()
  vim.ui.input({ prompt = "Session name: " }, function(name)
    if name then
      require("mini.sessions").write(name)
    end
  end)
end, { desc = "Save session with name" })
