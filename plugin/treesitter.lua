-- Install nvim-treesitter via vim.pack
vim.pack.add({
  { src = "https://github.com/nvim-treesitter/nvim-treesitter" },
})

-- Ensure Treesitter is loaded before config runs
vim.defer_fn(function()
  local ok, configs = pcall(require, "nvim-treesitter.configs")
  if not ok then
    return
  end

  configs.setup({
    -- Only install what you need
    ensure_installed = {
      "javascript",
      "typescript",
      "tsx",
      "rust",
      "c",
      "cpp",
    },

    -- Auto install missing parsers when opening a file
    auto_install = true,

    highlight = {
      enable = true,
      additional_vim_regex_highlighting = false,
    },

    indent = {
      enable = true,
    },

    -- Optional but useful
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = "gnn",
        node_incremental = "grn",
        scope_incremental = "grc",
        node_decremental = "grm",
      },
    },
  })
end, 0)
