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
	{
		"mrjones2014/smart-splits.nvim",
		build = "./kitty/install-kittens.bash",
		opts = {},
	},
	{
		"fouladi/toggle-overlength.nvim",
		opts = function()
			local color
			if vim.o.background == "dark" then
				color = "#56526e"
			else
				color = "#cecacd"
			end
			return {
				guibg = color,
			}
		end,
		config = function(_, opts)
			require("toggle-overlength").setup(opts)
			vim.api.nvim_create_autocmd("bufReadPre", {
				command = "ToggleHiOverLength",
			})
			vim.keymap.del("n", "<leader>th")
			vim.keymap.set(
				"n",
				"<leader>ol",
				"<cmd>ToggleHiOverLength<cr>",
				{ desc = "toggle _o_ver_l_ength line (toggle-overlength)" }
			)
		end,
	},
}
