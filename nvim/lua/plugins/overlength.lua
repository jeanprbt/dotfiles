return {
	"fouladi/toggle-overlength.nvim",
	opts = {},
	config = function(_, opts)
		require("toggle-overlength").setup(opts)
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
