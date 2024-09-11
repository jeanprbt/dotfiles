return {
	"fouladi/toggle-overlength.nvim",
	config = function()
		require("toggle-overlength").setup({})
		vim.api.nvim_create_autocmd("bufReadPre", {
			command = "ToggleHiOverLength",
		})
		vim.keymap.del("n", "<leader>th")
		vim.keymap.set(
			"n",
			"<leader>o",
			"<cmd>ToggleHiOverLength<cr>",
			{ desc = "Toggle overlength line (toggle-overlength)" }
		)
	end,
}
