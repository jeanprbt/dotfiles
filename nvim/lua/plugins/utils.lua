return {
	{
		"echasnovski/mini.pairs",
		config = function()
			require("mini.pairs").setup({})
		end,
	},
	{
		"echasnovski/mini.surround",
		version = "*",
		config = function()
			require("mini.surround").setup({
				mappings = {
					add = "<leader>sa",
					delete = "<leader>sd",
					find = "<leader>sf",
					find_left = "<leader>sF",
					highlight = "<leader>sh",
					replace = "<leader>sr",
				},
				highlight_duration = 2000,
			})
		end,
	},
	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		config = function()
			require("ibl").setup({
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
			})
		end,
	},
}
