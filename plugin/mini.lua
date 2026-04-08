vim.pack.add({ 'https://github.com/nvim-mini/mini.nvim' })
require('mini.ai').setup()
require('mini.surround').setup()
require('mini.basics').setup()
require('mini.icons').setup()
require('mini.pairs').setup()

--mini.pick
require("mini.pick").setup({
  options = {
    use_cache = true,
  },

  window = {
    config = function()
      local height = math.floor(0.6 * vim.o.lines)
      local width = math.floor(0.6 * vim.o.columns)
      return {
        border = "rounded",
        height = height,
        width = width,
        row = math.floor(0.5 * (vim.o.lines - height)),
        col = math.floor(0.5 * (vim.o.columns - width)),
      }
    end,
  },
})

vim.api.nvim_set_hl(0, "MiniPickNormal", { link = "NormalFloat" })
vim.api.nvim_set_hl(0, "MiniPickBorder", { link = "FloatBorder" })
vim.api.nvim_set_hl(0, "MiniPickMatchCurrent", { link = "Visual" })
vim.api.nvim_set_hl(0, "MiniPickMatchMarked", { link = "Search" })
vim.api.nvim_set_hl(0, "MiniPickPrompt", { link = "Title" })

local pick = require('mini.pick')

-- Files
vim.keymap.set("n", "<leader>ff", function()
  pick.builtin.files({}, { preview = true })
end, { desc = "Find files" })

-- Live grep (requires ripgrep)
vim.keymap.set("n", "<leader>fg", function()
  pick.builtin.grep_live({}, { preview = true })
end, { desc = "Live grep" })

-- Buffers
vim.keymap.set("n", "<leader>fb", function()
  pick.builtin.buffers({}, { preview = true })
end, { desc = "Buffers" })

-- help tags
vim.keymap.set("n", "<leader>fh", function()
  pick.builtin.help({}, { preview = true })
end, { desc = "Help tags" })

-- Recent files
vim.keymap.set("n", "<leader>fr", function()
  pick.builtin.oldfiles({}, { preview = true })
end, { desc = "Recent files" })

-- Diagnostics
vim.keymap.set("n", "<leader>fd", function()
  pick.builtin.diagnostic({}, { preview = true })
end, { desc = "Diagnostics" })

-- LSP symbols (document)
vim.keymap.set("n", "<leader>fs", function()
  pick.builtin.lsp({ scope = "document" }, { preview = true })
end, { desc = "LSP symbols" })

vim.keymap.set("n", "<leader>gf", function()
  require("mini.pick").builtin.git_files({}, { preview = true })
end, { desc = "Git files" })

vim.keymap.set("n", "<leader>fS", function()
  require("mini.pick").builtin.lsp({ scope = "workspace" }, { preview = true })
end, { desc = "Workspace symbols" })





-- mini.completions 
require("mini.completion").setup({
  -- Auto completion
  delay = { completion = 100, info = 200, signature = 200 },

  -- Window configuration
  window = {
    info = { border = "rounded" },
    signature = { border = "rounded" },
  },

  -- LSP completion behavior
  lsp_completion = {
    source_func = "completefunc", -- use built-in completion
    auto_setup = true,
  },

  -- Fallback action if no completion
  fallback_action = "<C-n>",
})

-- Better completion UX
vim.opt.completeopt = { "menu", "menuone", "noselect" }
vim.opt.shortmess:append("c")

-- 🔑 Keymaps (clean + intuitive)

-- Navigate completion
vim.keymap.set("i", "<C-n>", function()
  return vim.fn.pumvisible() == 1 and "<C-n>" or "<Down>"
end, { expr = true })

vim.keymap.set("i", "<C-p>", function()
  return vim.fn.pumvisible() == 1 and "<C-p>" or "<Up>"
end, { expr = true })

-- Confirm selection
vim.keymap.set("i", "<CR>", function()
  if vim.fn.pumvisible() == 1 then
    return "<C-y>"
  end
  return "<CR>"
end, { expr = true })

-- Manual trigger (optional)
vim.keymap.set("i", "<C-Space>", function()
  vim.lsp.completion.get()
end, { desc = "Trigger completion" })

-- Close completion cleanly
vim.keymap.set("i", "<Esc>", function()
  return vim.fn.pumvisible() == 1 and "<C-e><Esc>" or "<Esc>"
end, { expr = true })


































--override 
vim.opt.clipboard = "unnamedplus"
vim.opt.relativenumber = true
-- Maximize current window (close other splits)
vim.keymap.set("n", "<leader>sm", "<C-w>o", { desc = "Maximize current window" })

-- Close current tab
vim.keymap.set("n", "<leader>sx", ":tabclose<CR>", { desc = "Close current tab" })

-- Navigate tabs using Ctrl + h/j/k/l
vim.keymap.set("n", "<C-l>", ":tabnext<CR>", { desc = "Next tab" })
vim.keymap.set("n", "<C-h>", ":tabprevious<CR>", { desc = "Previous tab" })

-- Optional (since j/k don't naturally map to tabs, but adding for consistency)
vim.keymap.set("n", "<C-j>", ":tabnext<CR>")
vim.keymap.set("n", "<C-k>", ":tabprevious<CR>")
