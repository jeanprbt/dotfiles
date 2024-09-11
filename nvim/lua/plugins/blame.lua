return {
	"f-person/git-blame.nvim",
	event = "VeryLazy",
	config = function()
		vim.api.nvim_set_hl(0, "GitBlame", { fg = "#a6e3a2", italic = true })
		require("gitblame").setup({
			enabled = true,
			message_template = " <summary> • <date> • <author> • <<sha>>",
			date_format = "%m-%d-%Y %H:%M:%S",
			virtual_text_column = 1,
			delay = 0,
			ignored_filetypes = { "markdown" },
			highlight_group = "GitBlame",
		})
		vim.keymap.set("n", "<leader>gb", ":GitBlameToggle<cr>", { desc = "Toggle git blame (git-blame)" })
	end,
}
