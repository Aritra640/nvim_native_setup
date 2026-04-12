-- =========================
-- 📦 INSTALL
-- =========================
vim.pack.add({
  { src = "https://github.com/szw/vim-maximizer" },
})

-- =========================
-- ⚙️ LOAD (important)
-- =========================
vim.cmd("packadd vim-maximizer")

-- =========================
-- 🔑 KEYMAP
-- =========================
vim.keymap.set("n", "<leader>sm", "<cmd>MaximizerToggle<CR>", {
  desc = "Maximize/minimize a split",
})
