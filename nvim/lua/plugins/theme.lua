return {
	{
		"rose-pine/neovim",
		name = "rose-pine",
		opts = {
			dark_variant = "moon",
			highlight_groups = {
				MatchParen = { fg = "gold", bg = "rose" },
				DapUIPlayPause = { fg = "foam" },
				DapUIStepOver = { fg = "pine" },
				DapUIStepInto = { fg = "pine" },
				DapUIStepBack = { fg = "pine" },
				DapUIStepOut = { fg = "pine" },
				DapUIStop = { fg = "rose" },
				DapUIRestart = { fg = "rose" },
				DapBreakPoint = { fg = "love" },
			},
		},
		config = function(_, opts)
			require("rose-pine").setup(opts)
			vim.cmd("colorscheme rose-pine")
		end,
	},
}
