return {
	{
		"echasnovski/mini.pairs",
		config = true,
	},
	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		opts = {
			scope = {
				enabled = false,
			},
			exclude = {
				filetypes = {
					"NvimTree",
					"Lazy",
					"Mason",
					"dashboard",
					"help",
					"lspinfo",
					"man",
					"Trouble",
					"gitcommit",
					"TelescopePrompt",
					"TelescopeResults",
					"''",
				},
				buftypes = {
					"terminal",
					"nofile",
					"quickfix",
					"prompt",
				},
			},
		},
	},
	{
		"stevearc/dressing.nvim",
		event = "VeryLazy",
		config = true,
	},
}
