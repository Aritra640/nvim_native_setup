-- 📦 Install plugin
vim.pack.add({
	{ src = "https://github.com/stevearc/conform.nvim" },
})

-- ⚙️ Setup
require('conform').setup({
	formatters_by_ft = {
		-- Web stack
		javascript = { "prettier" },
		typescript = { "prettier" },
		javascriptreact = { "prettier" },
		typescriptreact = { "prettier" },

		html = { "prettier" },
		css = { "prettier" },
		json = { "prettier" },
		yaml = { "prettier" },
		markdown = { "prettier" },

		-- 🔥 Prisma (added)
		prisma = { "prettier" },

		-- Other languages
		lua = { "stylua" },
		cpp = { "clang-format" },
	},
})

-- 🔑 Manual format keymap
vim.keymap.set({ "n", "v" }, "<leader>mp", function()
	require('conform').format({
		lsp_fallback = true,
		async = false,
		timeout_ms = 1000,
	})
end, { desc = "Format file or range" })
