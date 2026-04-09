-- =========================
-- PLUGIN
-- =========================
vim.pack.add({
  { src = "https://github.com/mfussenegger/nvim-lint" },
})

-- REQUIRED for vim.pack
vim.cmd("packadd nvim-lint")

-- =========================
-- REQUIRE
-- =========================
local ok, lint = pcall(require, "lint")
if not ok then
  return
end

-- =========================
-- LINTERS
-- =========================
lint.linters_by_ft = {
  rust = { "clippy" },

  javascript = { "eslint_d" },
  typescript = { "eslint_d" },
  javascriptreact = { "eslint_d" },
  typescriptreact = { "eslint_d" },
}

-- =========================
-- AUTOCMD
-- =========================
local lint_augroup = vim.api.nvim_create_augroup("linting", { clear = true })

vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
  group = lint_augroup,
  callback = function()
    lint.try_lint()
  end,
})

-- =========================
-- KEYMAP
-- =========================
vim.keymap.set("n", "<leader>ml", function()
  lint.try_lint()
end, { desc = "Trigger linting" })
