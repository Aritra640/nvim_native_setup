-- Install nvim-lint using vim.pack
vim.pack.add({
  { src = "https://github.com/mfussenegger/nvim-lint" },
})

-- Safely require
local ok, lint = pcall(require, "lint")
if not ok then
  return
end

-- Configure linters per filetype
lint.linters_by_ft = {
  rust = { "clippy" },         -- uses cargo clippy
  javascript = { "eslint_d" }, -- faster eslint
}

-- Optional: fallback if eslint_d not available
-- lint.linters_by_ft.javascript = { "eslint" }

-- Auto trigger linting
local lint_augroup = vim.api.nvim_create_augroup("linting", { clear = true })

vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
  group = lint_augroup,
  callback = function()
    lint.try_lint()
  end,
})

-- Optional keymap to manually trigger lint
vim.keymap.set("n", "<leader>ml", function()
  lint.try_lint()
end, { desc = "Trigger linting" })
