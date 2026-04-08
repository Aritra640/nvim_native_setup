-- Install pluins
vim.pack.add({
  { src = "https://github.com/nvim-tree/nvim-tree.lua" },
  { src = "https://github.com/nvim-tree/nvim-web-devicons" },
})

-- Disable netrw (must be BEFORE setup)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Setup nvim-tree
require("nvim-tree").setup({
  view = {
    width = 34,
    relativenumber = true,
  },
  renderer = {
    indent_markers = {
      enable = true,
    },
    icons = {
      glyphs = {
        folder = {
          arrow_closed = "",
          arrow_open = "",
        },
      },
    },
  },
  actions = {
    open_file = {
      window_picker = {
        enable = false,
      },
    },
  },
  filters = {
    custom = { ".DS_Store" },
  },
  git = {
    ignore = false,
  },
})

-- Keymaps
vim.keymap.set("n", "<leader>ee", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle explorer" })
vim.keymap.set("n", "<leader>ef", "<cmd>NvimTreeFindFileToggle<CR>", { desc = "Find file" })
vim.keymap.set("n", "<leader>ec", "<cmd>NvimTreeCollapse<CR>", { desc = "Collapse tree" })
vim.keymap.set("n", "<leader>er", "<cmd>NvimTreeRefresh<CR>", { desc = "Refresh tree" })
