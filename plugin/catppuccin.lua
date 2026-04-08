vim.pack.add { { src = "https://github.com/catppuccin/nvim", name = "catppuccin" } }

require('catppuccin').setup({
	flavour = "mocha",
	background = {
		light = "latte",
		dark = "mocha",
	},
	transparent_background = false,
	term_colors = true,
	integrations = {
		treesitter = true,
		native_lsp = true,
	},
})

vim.cmd.colorscheme('catppuccin')
