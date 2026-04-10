-- =========================
-- PLUGIN
-- =========================
vim.pack.add({
  { src = "https://github.com/neovim/nvim-lspconfig" },
})

-- REQUIRED for vim.pack
vim.cmd("packadd nvim-lspconfig")

-- =========================
-- CMP CAPABILITIES (IMPORTANT)
-- =========================
local capabilities = vim.lsp.protocol.make_client_capabilities()

-- if cmp exists, enhance capabilities
local ok_cmp, cmp_lsp = pcall(require, "cmp_nvim_lsp")
if ok_cmp then
  capabilities = cmp_lsp.default_capabilities(capabilities)
end

-- =========================
-- ENABLE LSPS
-- =========================
vim.lsp.enable({
  "lua_ls",
  "rust_analyzer",
  "tsserver",
  "html",
  "cssls",
  "prismals",
})

-- =========================
-- LSP CONFIGS
-- =========================

-- Lua
vim.lsp.config("lua_ls", {
  capabilities = capabilities,
  settings = {
    Lua = {
      diagnostics = {
        globals = { "vim" },
      },
      workspace = {
        checkThirdParty = false,
      },
    },
  },
})

-- TypeScript
vim.lsp.config("tsserver", {
  capabilities = capabilities,
  root_markers = { "package.json", "tsconfig.json", ".git" },
})

-- Rust
vim.lsp.config("rust_analyzer", {
  capabilities = capabilities,
})

-- HTML
vim.lsp.config("html", {
  capabilities = capabilities,
})

-- CSS
vim.lsp.config("cssls", {
  capabilities = capabilities,
})

-- Prisma
vim.lsp.config("prismals", {
  capabilities = capabilities,
  filetypes = { "prisma" },
})

-- =========================
-- DIAGNOSTICS UI
-- =========================
vim.diagnostic.config({
  virtual_text = {
    spacing = 2,
    prefix = "●",
  },
  float = {
    border = "rounded",
  },
  signs = true,
  underline = true,
  update_in_insert = false,
})

-- =========================
-- HOVER DIAGNOSTICS
-- =========================
vim.api.nvim_create_autocmd("CursorHold", {
  callback = function()
    vim.diagnostic.open_float(nil, { focus = false })
  end,
})

-- =========================
-- ON ATTACH KEYMAPS
-- =========================
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local opts = { buffer = args.buf }

    -- Navigation
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
    vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)

    -- Info
    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)

    -- Actions
    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
    vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
  end,
})

-- =========================
-- COMPLETEOPT (CMP)
-- =========================
vim.opt.completeopt = { "menu", "menuone", "noselect" }
