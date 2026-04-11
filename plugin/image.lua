-- =========================
-- PLUGIN
-- =========================
vim.pack.add({
  { src = "https://github.com/3rd/image.nvim" },
})

-- =========================
-- SETUP
-- =========================
require("image").setup({
  backend = "ascii", -- ZERO dependencies

  integrations = {
    markdown = {
      enabled = true,
      clear_in_insert_mode = false,
      download_remote_images = true,
      only_render_image_at_cursor = false,
    },
  },

  max_width = 100,
  max_height = 20,

  editor_only_render_when_focused = true,
})
