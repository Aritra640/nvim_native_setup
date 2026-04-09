-- =========================
-- PLUGIN
-- =========================
vim.pack.add({
	{ src = "https://github.com/stevearc/conform.nvim" },
})

-- REQUIRED for vim.pack
vim.cmd("packadd conform.nvim")

-- =========================
-- SETUP
-- =========================
require("conform").setup({
	log_level = vim.log.levels.ERROR, -- change to DEBUG if needed

	formatters_by_ft = {
		javascript = { "prettier" },
		typescript = { "prettier" },
		javascriptreact = { "prettier" },
		typescriptreact = { "prettier" },

		html = { "prettier" },
		css = { "prettier" },
		json = { "prettier" },
		yaml = { "prettier" },
		markdown = { "prettier" },
		prisma = { "prettier" },

		lua = { "stylua" },
		cpp = { "clang-format" },
	},
})

-- =========================
-- KEYMAP
-- =========================
vim.keymap.set({ "n", "v" }, "<leader>mp", function()
	require("conform").format({
		lsp_fallback = true,
		async = false,
		timeout_ms = 2000,
	})
end, { desc = "Format file or range" })
