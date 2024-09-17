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
			"<leader>rf",
			"<cmd>Trouble lsp_references toggle filter.buf=0<cr>",
			{ desc = "Toggle references (trouble)" }
		)
		vim.keymap.set(
			"n",
			"<leader>d",
			"<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
			{ desc = "Toggle diagnostics (trouble)" }
		)
	end,
}
