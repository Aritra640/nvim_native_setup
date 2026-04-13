-- =========================
-- PLUGINS
-- =========================
vim.pack.add({
  { src = "https://github.com/echasnovski/mini.nvim" },
})

-- =========================
-- MINI.COMPLETION (AUTO)
-- =========================
require("mini.completion").setup({
  delay = {
    completion = 200,
    info = 100,
    signature = 50,
  },
  window = {
    info = { border = "rounded" },
    signature = { border = "rounded" },
  },
})

-- REQUIRED
vim.opt.completeopt = "menuone,noinsert,noselect"

-- =========================
-- LSP STARTER (FIXED)
-- =========================
local function start_lsp(config)
  vim.api.nvim_create_autocmd("FileType", {
    pattern = config.filetypes,
    callback = function()
      local root = vim.fs.root(0, config.root_markers)
      if not root then return end

      vim.lsp.start({
        name = config.name,
        cmd = config.cmd,
        root_dir = root,
        settings = config.settings, -- ✅ CRITICAL FIX
      })
    end,
  })
end

-- =========================
-- LUA (FIXED)
-- =========================
start_lsp({
  name = "lua_ls",
  cmd = { "lua-language-server" },
  filetypes = { "lua" },
  root_markers = { ".git", ".luarc.json" },
  settings = {
    Lua = {
      runtime = {
        version = "LuaJIT",
      },
      diagnostics = {
        globals = { "vim" },
      },
      workspace = {
        library = vim.api.nvim_get_runtime_file("", true),
        checkThirdParty = false,
      },
      telemetry = {
        enable = false,
      },
    },
  },
})

-- =========================
-- TYPESCRIPT / REACT
-- =========================
start_lsp({
  name = "ts_ls",
  cmd = { "typescript-language-server", "--stdio" },
  filetypes = {
    "javascript",
    "javascriptreact",
    "typescript",
    "typescriptreact",
  },
  root_markers = { "package.json", "tsconfig.json", ".git" },
})

-- =========================
-- GO
-- =========================
start_lsp({
  name = "gopls",
  cmd = { "gopls" },
  filetypes = { "go" },
  root_markers = { "go.mod", "go.work", ".git" },
})

-- =========================
-- HTML
-- =========================
start_lsp({
  name = "html",
  cmd = { "vscode-html-language-server", "--stdio" },
  filetypes = { "html" },
  root_markers = { ".git", "package.json" },
})

-- =========================
-- TAILWIND (WITH JSX SUPPORT)
-- =========================
start_lsp({
  name = "tailwindcss",
  cmd = { "tailwindcss-language-server", "--stdio" },
  filetypes = {
    "html",
    "css",
    "javascript",
    "javascriptreact",
    "typescript",
    "typescriptreact",
  },
  root_markers = {
    "tailwind.config.js",
    "tailwind.config.ts",
    "postcss.config.js",
    "package.json",
    ".git",
  },
  settings = {
    tailwindCSS = {
      experimental = {
        classRegex = {
          "className=\"([^\"]*)\"",
          "class=\"([^\"]*)\"",
        },
      },
    },
  },
})

-- =========================
-- RUST
-- =========================
start_lsp({
  name = "rust_analyzer",
  cmd = { "rust-analyzer" },
  filetypes = { "rust" },
  root_markers = { "Cargo.toml", ".git" },
})

-- =========================
-- LSP ATTACH
-- =========================
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local buf = args.buf

    -- 🔥 REQUIRED for completion
    vim.bo[buf].omnifunc = "v:lua.vim.lsp.omnifunc"

    local opts = { buffer = buf }

    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
    vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
    vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
  end,
})

-- =========================
-- COMPLETION KEYMAPS
-- =========================
vim.keymap.set("i", "<Tab>", function()
  if vim.fn.pumvisible() == 1 then return "<C-n>" end
  return "<Tab>"
end, { expr = true })

vim.keymap.set("i", "<S-Tab>", function()
  if vim.fn.pumvisible() == 1 then return "<C-p>" end
  return "<S-Tab>"
end, { expr = true })

vim.keymap.set("i", "<C-n>", function()
  if vim.fn.pumvisible() == 1 then return "<C-n>" end
  return "<Down>"
end, { expr = true })

vim.keymap.set("i", "<C-p>", function()
  if vim.fn.pumvisible() == 1 then return "<C-p>" end
  return "<Up>"
end, { expr = true })

vim.keymap.set("i", "<CR>", function()
  if vim.fn.pumvisible() == 1 then
    return "<C-y><C-e>" -- ✅ confirm + close menu
  end
  return "<CR>"
end, { expr = true })

