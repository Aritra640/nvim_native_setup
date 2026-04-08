-- 📦 Install plugin
vim.pack.add({
	{ src = "https://github.com/neovim/nvim-lspconfig" },
})

-- ⚙️ Enable LSPs
vim.lsp.enable({
	"lua_ls",
	"rust_analyzer",
	"tsserver",
	"html",
	"cssls",
	"prismals",
})

-- 🔧 Lua LSP fix (Neovim globals)
vim.lsp.config("lua_ls", {
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

-- 🔧 tsserver root fix (important for projects)
vim.lsp.config("tsserver", {
	root_markers = { "package.json", "tsconfig.json", ".git" },
})

-- 🔧 Prisma (safe fallback)
vim.lsp.config("prismals", {
	filetypes = { "prisma" },
})

-- 🎯 Diagnostics UI (clean + modern)
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

-- Optional: show diagnostics on hover
vim.api.nvim_create_autocmd("CursorHold", {
	callback = function()
		vim.diagnostic.open_float(nil, { focus = false })
	end,
})

-- 🧠 LSP keymaps (buffer-local, only when attached)
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

		-- -- ✅ Manual format (your preference)
		-- vim.keymap.set("n", "<leader>mp", function()
		-- 	vim.lsp.buf.format({ async = true })
		-- end, { desc = "default format code" })
	end,
})

-- 🔧 Completion behavior (built-in)
vim.opt.completeopt = { "menu", "menuone", "noselect" }


-- restrict tsserver from hitting conflicts
vim.lsp.buf.format({
	async = true,
	filter = function(client)
		return client.name ~= "tsserver"
	end,
})
