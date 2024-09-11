return {
	"folke/trouble.nvim",
	config = function()
		require("trouble").setup({
			focus = true,
			warn_no_results = false,
			auto_close = true,
		})
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
