-- =========================
-- PLUGIN (keep here as requested)
-- =========================
vim.pack.add({
  { src = "https://github.com/stevearc/conform.nvim" },
})

-- =========================
-- SAFE LOAD (CRITICAL)
-- =========================
local ok_pack = pcall(vim.cmd, "packadd conform.nvim")
if not ok_pack then
  return
end

local ok, conform = pcall(require, "conform")
if not ok then
  return
end

-- =========================
-- SETUP
-- =========================
conform.setup({
  log_level = vim.log.levels.ERROR,

  formatters_by_ft = {
    javascript = { "prettier" },
    typescript = { "prettier" },
    javascriptreact = { "prettier" },
    typescriptreact = { "prettier" },

    html = { "prettier" },
    css = { "prettier" },
    json = { "prettier" },
    yaml = { "prettier" },
    markdown = { "prettier" },
    prisma = { "prettier" },

    lua = { "stylua" },
    cpp = { "clang-format" },
  },
})

-- =========================
-- KEYMAP (DEFERRED = FIXES YOUR BUG)
-- =========================
vim.schedule(function()
  vim.keymap.set({ "n", "v" }, "<leader>mp", function()
    conform.format({
      lsp_fallback = true,
      async = false,
      timeout_ms = 2000,
    })
  end, { desc = "Format file or range" })
end)
