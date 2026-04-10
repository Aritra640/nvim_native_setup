-- =========================
-- PLUGINS
-- =========================
vim.pack.add({
  { src = "https://github.com/hrsh7th/nvim-cmp" },
  { src = "https://github.com/hrsh7th/cmp-nvim-lsp" },
  { src = "https://github.com/hrsh7th/cmp-buffer" },
  { src = "https://github.com/hrsh7th/cmp-path" },

  { src = "https://github.com/L3MON4D3/LuaSnip" },
  { src = "https://github.com/saadparwaiz1/cmp_luasnip" },
  { src = "https://github.com/rafamadriz/friendly-snippets" },

  { src = "https://github.com/onsails/lspkind.nvim" },

  -- 🔥 auto tag (VERY IMPORTANT for React/HTML)
  { src = "https://github.com/windwp/nvim-ts-autotag" },
})

-- =========================
-- LAZY LOAD ON INSERT
-- =========================
vim.api.nvim_create_autocmd("InsertEnter", {
  once = true,
  callback = function()
    -- =========================
    -- PACKADD (vim.pack fix)
    -- =========================
    vim.cmd("packadd nvim-cmp")
    vim.cmd("packadd cmp-nvim-lsp")
    vim.cmd("packadd LuaSnip")
    vim.cmd("packadd cmp_luasnip")
    vim.cmd("packadd friendly-snippets")
    vim.cmd("packadd lspkind.nvim")
    vim.cmd("packadd nvim-ts-autotag")

    local cmp = require("cmp")
    local luasnip = require("luasnip")
    local lspkind = require("lspkind")

    -- =========================
    -- SNIPPETS
    -- =========================
    require("luasnip.loaders.from_vscode").lazy_load()

    -- =========================
    -- AUTOTAG (React/HTML)
    -- =========================
    require("nvim-ts-autotag").setup()

    -- =========================
    -- CMP SETUP
    -- =========================
    cmp.setup({
      completion = {
        completeopt = "menu,menuone,noinsert",
      },

      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },

      mapping = cmp.mapping.preset.insert({
        ["<C-j>"] = cmp.mapping.select_next_item(),
        ["<C-k>"] = cmp.mapping.select_prev_item(),

        ["<Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          elseif luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
          else
            fallback()
          end
        end, { "i", "s" }),

        ["<S-Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif luasnip.jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { "i", "s" }),

        ["<C-d>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),

        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.abort(),

        ["<CR>"] = cmp.mapping.confirm({ select = true }),
      }),

      sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "luasnip" },
        { name = "buffer" },
        { name = "path" },
      }),

      formatting = {
        format = lspkind.cmp_format({
          maxwidth = 50,
          ellipsis_char = "...",
        }),
      },
    })
  end,
})

-- =========================
-- LSP CAPABILITIES (CRITICAL)
-- =========================
-- Use this in your LSP config
_G.cmp_capabilities = require("cmp_nvim_lsp").default_capabilities()
