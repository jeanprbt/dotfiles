return {
	"f-person/git-blame.nvim",
	event = "VeryLazy",
	opts = {
		enabled = false,
		message_template = "󰊢 <summary> • <date> • <author> • <<sha>>",
		date_format = "%m-%d-%Y %H:%M:%S",
		virtual_text_column = 1,
		delay = 0,
		ignored_filetypes = { "markdown" },
		highlight_group = "GitBlame",
	},
	config = function(_, opts)
		require("gitblame").setup(opts)
		vim.api.nvim_set_hl(0, "GitBlame", { fg = "#e34626", italic = true })
		vim.keymap.set("n", "<leader>gb", ":GitBlameToggle<cr>", { desc = "Toggle git blame (git-blame)" })
	end,
}
