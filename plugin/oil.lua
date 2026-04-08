-- Install plugin
vim.pack.add({
  { src = "https://github.com/stevearc/oil.nvim" },
})

-- Setup
require("oil").setup({
  default_file_explorer = true, -- replaces netrw

  columns = {
    "icon",
    "permissions",
    "size",
    "mtime",
  },

  view_options = {
    show_hidden = true,
  },

  float = {
    padding = 2,
    max_width = 80,
    max_height = 20,
    border = "rounded",
  },

  keymaps = {
    ["<CR>"] = "actions.select",
    ["<C-v>"] = "actions.select_vsplit",
    ["<C-s>"] = "actions.select_split",
    ["q"] = "actions.close",
    ["<BS>"] = "actions.parent",
    ["_"] = "actions.open_cwd",
  },
})


-- Open oil in current directory
vim.keymap.set("n", "<leader>oe", function()
  require("oil").open()
end, { desc = "Open file explorer (oil)" })

-- Open oil as floating window
vim.keymap.set("n", "<leader>of", function()
  require("oil").open_float()
end, { desc = "Open oil (float)" })

-- Open parent directory
vim.keymap.set("n", "<leader>op", function()
  require("oil").open(vim.fn.expand("%:p:h"))
end, { desc = "Open parent dir (oil)" })
