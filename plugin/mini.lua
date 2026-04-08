vim.pack.add({ 'https://github.com/nvim-mini/mini.nvim' })
require('mini.ai').setup()
require('mini.surround').setup()
require('mini.basics').setup()
require('mini.icons').setup()

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



-- mini.statusline
require("mini.statusline").setup({
  content = {
    active = function()
      local MiniStatusline = require("mini.statusline")
      local devicons = require("nvim-web-devicons")

      -- 🔹 Filename + icon
      local filename = vim.fn.expand("%:t")
      if filename == "" then filename = "[No Name]" end

      local icon, icon_hl = devicons.get_icon(filename, nil, { default = true })

      -- 🔹 LSP
      local clients = vim.lsp.get_clients({ bufnr = 0 })
      local lsp = ""
      if clients and #clients > 0 then
        lsp = " " .. table.concat(vim.tbl_map(function(c)
          return c.name
        end, clients), ",")
      end

      -- 🔹 Sections
      local mode = MiniStatusline.section_mode({ trunc_width = 120 })
      local git = MiniStatusline.section_git({ trunc_width = 40 }) or ""
      local diag = MiniStatusline.section_diagnostics({ trunc_width = 75 }) or ""

      return table.concat({
        -- Mode
        "%#SLMode#  " .. mode .. " ",

        -- File (icon + name)
        "%#SLFile# ",
        (icon_hl and "%#" .. icon_hl .. "#" .. icon .. " " or ""),
        filename .. " ",

        "%#SLDim#│",

        -- Git + diagnostics
        "%#SLGit# " .. git,
        "%#SLDiag# " .. diag,

        "%=",

        -- LSP
        "%#SLLsp# " .. lsp .. " ",

        "%#SLDim#│ %l:%c ",
      })
    end,
  },
})

vim.api.nvim_set_hl(0, "SLMode", { fg = "#0b0f14", bg = "#7aa2f7", bold = true })
vim.api.nvim_set_hl(0, "SLFile", { fg = "#e5e9f0", bg = "#2e3440", bold = true })

vim.api.nvim_set_hl(0, "SLGit", { fg = "#98c379", bg = "NONE" })
vim.api.nvim_set_hl(0, "SLDiag", { fg = "#e06c75", bg = "NONE" })
vim.api.nvim_set_hl(0, "SLLsp", { fg = "#e5c07b", bg = "NONE" })

vim.api.nvim_set_hl(0, "SLDim", { fg = "#5c6370", bg = "NONE" })
































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
