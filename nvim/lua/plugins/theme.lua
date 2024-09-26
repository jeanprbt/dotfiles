return {
	{
		"rose-pine/neovim",
		name = "rose-pine",
		opts = {
			dark_variant = "moon",
			highlight_groups = {
				MatchParen = { fg = "gold", bg = "rose" },
			},
		},
		config = function(_, opts)
			require("rose-pine").setup(opts)
			vim.cmd("colorscheme rose-pine")
		end,
	},
}
