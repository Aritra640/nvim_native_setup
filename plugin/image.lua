vim.pack.add({
  { src = "https://github.com/3rd/image.nvim" },
})

require("image").setup({
  backend = "kitty", -- required for wezterm

  processor = "magick_cli", -- requires ImageMagick

  integrations = {
    markdown = {
      enabled = true,
      clear_in_insert_mode = false,
      download_remote_images = true,
      only_render_image_at_cursor = false,
      floating_windows = false,
      filetypes = { "markdown", "norg" },
    },
  },

  max_width = 100,
  max_height = 12,

  max_width_window_percentage = math.huge,
  max_height_window_percentage = math.huge,

  window_overlap_clear_enabled = true,
  window_overlap_clear_ft_ignore = { "cmp_menu", "cmp_docs", "" },

  editor_only_render_when_focused = true,
  tmux_show_only_in_active_window = true,

  -- IMPORTANT: allow opening images directly
  hijack_file_patterns = { "*.png", "*.jpg", "*.jpeg", "*.gif", "*.webp" },
})

vim.keymap.set("n", "<leader>ki", function()
  require("image").toggle()
end, { desc = "Toggle images" })

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "image" },
  callback = function()
    -- prevent nvim-ts-autotag from crashing
    vim.b.ts_autotag_enabled = false
  end,
})

vim.api.nvim_create_autocmd("BufEnter", {
  callback = function(args)
    local ft = vim.bo[args.buf].filetype
    if ft == "image" then
      -- make it explicitly read-only UX-wise
      vim.bo[args.buf].modifiable = false
      vim.bo[args.buf].readonly = true
    end
  end,
})
