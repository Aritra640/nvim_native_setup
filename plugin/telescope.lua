-- =========================
-- PLUGINS (vim.pack)
-- =========================
vim.pack.add({
  { src = "https://github.com/nvim-lua/plenary.nvim" }, -- load FIRST (important)
  { src = "https://github.com/nvim-telescope/telescope.nvim" },
  { src = "https://github.com/nvim-telescope/telescope-fzf-native.nvim", build = "make" },
  { src = "https://github.com/nvim-tree/nvim-web-devicons" },
  { src = "https://github.com/folke/todo-comments.nvim" },
  { src = "https://github.com/folke/trouble.nvim" },
})

-- =========================
-- REQUIRED FOR vim.pack (IMPORTANT)
-- =========================
-- fzf-native is installed in /opt → must be loaded manually
vim.cmd("packadd telescope-fzf-native.nvim")

-- =========================
-- REQUIRE
-- =========================
local telescope = require("telescope")
local actions = require("telescope.actions")
local transform_mod = require("telescope.actions.mt").transform_mod
local trouble = require("trouble")
local trouble_telescope = require("trouble.sources.telescope")

-- =========================
-- CUSTOM ACTIONS
-- =========================
local custom_actions = transform_mod({
  open_trouble_qflist = function()
    trouble.toggle("quickfix")
  end,
})

-- =========================
-- TELESCOPE SETUP
-- =========================
telescope.setup({
  defaults = {
    prompt_prefix = "   ",
    selection_caret = " ",
    path_display = { "smart" },

    sorting_strategy = "ascending",

    layout_strategy = "horizontal",
    layout_config = {
      horizontal = {
        prompt_position = "top",
        preview_width = 0.55,
      },
      width = 0.9,
      height = 0.85,
      preview_cutoff = 0,
    },

    -- 🔥 Better ignore (performance)
    file_ignore_patterns = {
      "node_modules",
      ".git/",
      "dist",
      "build",
      "%.lock",
    },

    -- 🔥 Better grep performance
    vimgrep_arguments = {
      "rg",
      "--color=never",
      "--no-heading",
      "--with-filename",
      "--line-number",
      "--column",
      "--smart-case",
      "--hidden",
      "--glob=!**/.git/*",
    },

    mappings = {
      i = {
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,

        ["<C-q>"] =
          actions.send_selected_to_qflist + custom_actions.open_trouble_qflist,

        ["<C-t>"] = trouble_telescope.open,

        ["<C-d>"] = actions.preview_scrolling_down,
        ["<C-u>"] = actions.preview_scrolling_up,

        ["<Esc>"] = actions.close,
      },

      n = {
        ["<C-t>"] = trouble_telescope.open,
      },
    },
  },

  -- =========================
  -- PICKERS
  -- =========================
  pickers = {
    find_files = {
      hidden = true,
    },

    live_grep = {
      additional_args = function()
        return { "--hidden" }
      end,
    },

    buffers = {
      sort_mru = true,
      ignore_current_buffer = true,
    },
  },

  -- =========================
  -- EXTENSIONS
  -- =========================
  extensions = {
    fzf = {
      fuzzy = true,
      override_generic_sorter = true,
      override_file_sorter = true,
      case_mode = "smart_case",
    },
  },
})

-- =========================
-- LOAD EXTENSIONS (SAFE)
-- =========================
pcall(function()
  telescope.load_extension("fzf")
end)

-- =========================
-- HIGHLIGHTS (Catppuccin-friendly)
-- =========================
vim.api.nvim_set_hl(0, "TelescopeBorder", { link = "FloatBorder" })
vim.api.nvim_set_hl(0, "TelescopePromptBorder", { link = "FloatBorder" })
vim.api.nvim_set_hl(0, "TelescopeResultsBorder", { link = "FloatBorder" })
vim.api.nvim_set_hl(0, "TelescopePreviewBorder", { link = "FloatBorder" })

-- =========================
-- KEYMAPS
-- =========================
local keymap = vim.keymap.set

-- Files
keymap("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Find files" })
keymap("n", "<leader>fr", "<cmd>Telescope oldfiles<cr>", { desc = "Recent files" })

-- Search
keymap("n", "<leader>fs", "<cmd>Telescope live_grep<cr>", { desc = "Live grep" })
keymap("n", "<leader>fc", "<cmd>Telescope grep_string<cr>", { desc = "Word under cursor" })

-- Buffers
keymap("n", "<leader>fb", "<cmd>Telescope buffers<cr>", { desc = "Buffers" })

-- Help
keymap("n", "<leader>fh", "<cmd>Telescope help_tags<cr>", { desc = "Help tags" })

-- Todos
keymap("n", "<leader>ft", "<cmd>TodoTelescope<cr>", { desc = "Todos" })

-- =========================
-- LSP
-- =========================
keymap("n", "gd", "<cmd>Telescope lsp_definitions<cr>", { desc = "Definition" })
keymap("n", "gr", "<cmd>Telescope lsp_references<cr>", { desc = "References" })
keymap("n", "gi", "<cmd>Telescope lsp_implementations<cr>", { desc = "Implementations" })
keymap("n", "<leader>ds", "<cmd>Telescope lsp_document_symbols<cr>", { desc = "Document Symbols" })
keymap("n", "<leader>ws", "<cmd>Telescope lsp_workspace_symbols<cr>", { desc = "Workspace Symbols" })

-- Diagnostics
keymap("n", "<leader>fd", "<cmd>Telescope diagnostics<cr>", { desc = "Diagnostics" })
