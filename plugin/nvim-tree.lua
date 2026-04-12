-- =========================
-- 📦 INSTALL
-- =========================
vim.pack.add({
  { src = "https://github.com/nvim-tree/nvim-tree.lua" },
  { src = "https://github.com/nvim-tree/nvim-web-devicons" },
})

-- =========================
-- 🚫 DISABLE NETRW (EARLY)
-- =========================
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- =========================
-- ⚙️ SETUP (DEFERRED LIKE LAZY)
-- =========================
vim.schedule(function()
  require("nvim-tree").setup({
    view = {
      width = 36,
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

    update_focused_file = {
      enable = true,
      update_root = false,
    },

    filters = {
      custom = { ".DS_Store" },
    },

    git = {
      ignore = false,
    },
  })
end)

-- =========================
-- 🔒 HARD LOCK WINDOW (REAL FIX)
-- =========================
vim.api.nvim_create_autocmd("FileType", {
  pattern = "NvimTree",
  callback = function()
    vim.opt_local.number = false
    vim.opt_local.relativenumber = false
    vim.opt_local.signcolumn = "no"
    vim.opt_local.foldcolumn = "0"
    vim.opt_local.winfixwidth = true -- 🔥 prevents ALL resizing
  end,
})

-- =========================
-- ⚠️ GLOBAL WINDOW SAFETY
-- =========================
vim.opt.equalalways = false
-- vim.opt.winminwidth = 36

-- =========================
-- 🔑 KEYMAPS
-- =========================
vim.keymap.set("n", "<leader>ee", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle explorer" })
vim.keymap.set("n", "<leader>ef", "<cmd>NvimTreeFindFileToggle<CR>", { desc = "Find file" })
vim.keymap.set("n", "<leader>ec", "<cmd>NvimTreeCollapse<CR>", { desc = "Collapse tree" })
vim.keymap.set("n", "<leader>er", "<cmd>NvimTreeRefresh<CR>", { desc = "Refresh tree" })
