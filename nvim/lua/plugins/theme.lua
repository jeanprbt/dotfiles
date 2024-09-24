return {
	{
		"rose-pine/neovim",
		name = "rose-pine",
		opts = {
			dark_variant = "moon",
		},
		config = function(_, opts)
			require("rose-pine").setup(opts)
			vim.cmd("colorscheme rose-pine")
		end,
	},
}
