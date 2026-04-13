-- =========================
-- PLUGINS
-- =========================
vim.pack.add({
  { src = "https://github.com/L3MON4D3/LuaSnip" },
  { src = "https://github.com/rafamadriz/friendly-snippets" },
})

local luasnip = require("luasnip")
local s = luasnip.snippet
local t = luasnip.text_node
local i = luasnip.insert_node

-- =========================
-- LOAD DEFAULT SNIPPETS
-- =========================
require("luasnip.loaders.from_vscode").lazy_load()

-- =========================
-- HTML / JSX SNIPPETS
-- =========================
local function tag_snippet(trigger)
  return s(trigger, {
    t("<" .. trigger .. ">"),
    i(1),
    t("</" .. trigger .. ">"),
  })
end

luasnip.add_snippets("html", {
  tag_snippet("div"),
  tag_snippet("span"),
  tag_snippet("p"),
  tag_snippet("section"),
  tag_snippet("article"),
})

luasnip.add_snippets("javascriptreact", {
  tag_snippet("div"),
  tag_snippet("span"),
})

luasnip.add_snippets("typescriptreact", {
  tag_snippet("div"),
  tag_snippet("span"),
})

-- =========================
-- GENERIC TAG (🔥 dynamic)
-- type: tag → <tag></tag>
-- =========================
luasnip.add_snippets("html", {
  s("tag", {
    t("<"),
    i(1, "tag"),
    t(">"),
    i(2),
    t("</"),
    i(1),
    t(">"),
  }),
})

-- =========================
-- KEYMAPS (CRITICAL)
-- =========================
vim.keymap.set({ "i", "s" }, "<Tab>", function()
  if luasnip.expand_or_jumpable() then
    return "<Plug>luasnip-expand-or-jump"
  end
  if vim.fn.pumvisible() == 1 then
    return "<C-n>"
  end
  return "<Tab>"
end, { expr = true, silent = true })

vim.keymap.set({ "i", "s" }, "<S-Tab>", function()
  if luasnip.jumpable(-1) then
    return "<Plug>luasnip-jump-prev"
  end
  if vim.fn.pumvisible() == 1 then
    return "<C-p>"
  end
  return "<S-Tab>"
end, { expr = true, silent = true })
