-- 📦 Install plugins
vim.pack.add({
  { src = "https://github.com/nvim-lualine/lualine.nvim" },
  { src = "https://github.com/nvim-tree/nvim-web-devicons" },
})

-- ⚙️ Setup lualine
require("lualine").setup({
  options = {
    theme = "auto",
    section_separators = { left = "", right = "" },
    component_separators = { left = "│", right = "│" },
    globalstatus = true,
  },

  sections = {
    -- 🔹 Left
    lualine_a = {
      {
        function()
          if vim.fn.has("macunix") == 1 then
            return ""
          elseif vim.fn.has("win32") == 1 then
            return ""
          else
            return ""
          end
        end,
        padding = { left = 1, right = 0 },
      },
      {
        "mode",
        padding = { left = 0, right = 1 },
      },
    },

    lualine_b = {
      "branch",
      "diff",
    },

    -- 🔹 Center
    lualine_c = {
      {
        "filename",
        path = 1, -- relative path
        symbols = {
          modified = " ●",
          readonly = " ",
        },
      },
    },

    -- 🔹 Right
    lualine_x = {
      {
        function()
          local clients = vim.lsp.get_clients({ bufnr = 0 })
          if #clients == 0 then
            return ""
          end
          return " " .. table.concat(vim.tbl_map(function(c)
            return c.name
          end, clients), ",")
        end,
      },
      "filetype",
    },

    lualine_y = {
      "progress",
    },

    lualine_z = {
      "location",
    },
  },
})
