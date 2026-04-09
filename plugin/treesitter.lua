-- =========================
-- AUTOCMD: Recompile parsers on update
-- =========================
vim.api.nvim_create_autocmd("PackChanged", {
  callback = function(ev)
    local spec = ev.data.spec
    local kind = ev.data.kind

    if spec and spec.src and spec.src:match("nvim%-treesitter") and kind == "update" then
      if not ev.data.active then
        vim.cmd("packadd nvim-treesitter")
      end
      vim.cmd("TSUpdate")
    end
  end,
})

-- =========================
-- INSTALL (vim.pack)
-- =========================
vim.pack.add({
  { src = "https://github.com/nvim-treesitter/nvim-treesitter" },
  { src = "https://github.com/nvim-treesitter/nvim-treesitter-textobjects" },
  { src = "https://github.com/nvim-treesitter/nvim-treesitter-context" },
})

-- =========================
-- ENSURE LOADED
-- =========================
vim.cmd("packadd nvim-treesitter")
vim.cmd("packadd nvim-treesitter-textobjects")
vim.cmd("packadd nvim-treesitter-context")

-- =========================
-- SETUP
-- =========================
local ok, configs = pcall(require, "nvim-treesitter.configs")
if not ok then
  return
end

configs.setup({
  ensure_installed = {
    "lua",
    "go",
    "javascript",
    "typescript",
    "tsx",
    "rust",
    "c",
    "cpp",
    "json",
    "bash",
  },

  auto_install = true,

  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },

  indent = {
    enable = true,
  },

  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "gnn",
      node_incremental = "grn",
      scope_incremental = "grc",
      node_decremental = "grm",
    },
  },

  -- =========================
  -- TEXTOBJECTS
  -- =========================
  textobjects = {
    select = {
      enable = true,
      lookahead = true,

      keymaps = {
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ac"] = "@class.outer",
        ["ic"] = "@class.inner",
        ["aa"] = "@parameter.outer",
        ["ia"] = "@parameter.inner",
      },
    },

    move = {
      enable = true,
      set_jumps = true,

      goto_next_start = {
        ["]f"] = "@function.outer",
        ["]c"] = "@class.outer",
      },
      goto_previous_start = {
        ["[f"] = "@function.outer",
        ["[c"] = "@class.outer",
      },
    },
  },
})

-- =========================
-- CONTEXT (Sticky header)
-- =========================
require("treesitter-context").setup({
  enable = true,
  max_lines = 3,
  trim_scope = "outer",
})

-- =========================
-- BUILT-IN INSPECT (replaces playground)
-- =========================
vim.keymap.set("n", "<leader>ti", "<cmd>InspectTree<cr>", { desc = "Treesitter Inspect" })
