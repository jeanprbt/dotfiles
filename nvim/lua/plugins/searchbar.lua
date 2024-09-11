return {
	"VonHeikemen/searchbox.nvim",
	dependencies = {
		"MunifTanjim/nui.nvim",
	},
	config = function()
		require("searchbox").setup()
		vim.keymap.set(
			"n",
			"<leader>fi",
			"<cmd>SearchBoxMatchAll clear_matches=true<cr>",
			{ desc = "Find (searchbox)" }
		)
		vim.keymap.set("n", "<leader>re", "<cmd>SearchBoxReplace confirm=menu<cr>", { desc = "Find (searchbox)" })
	end,
}
