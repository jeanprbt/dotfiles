return {
	"folke/trouble.nvim",
	opts = {
		focus = true,
		warn_no_results = true,
		auto_close = true,
	},
	config = function(_, opts)
		require("trouble").setup(opts)
		vim.keymap.set(
			"n",
			"<leader>tr",
			"<cmd>Trouble lsp_references toggle filter.buf=0<cr>",
			{ desc = "_t_rouble references (trouble)" }
		)
		vim.keymap.set(
			"n",
			"<leader>td",
			"<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
			{ desc = "_t_rouble diagnostics (trouble)" }
		)
	end,
}
