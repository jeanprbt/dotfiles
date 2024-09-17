return {
	"MeanderingProgrammer/render-markdown.nvim",
	dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
	config = function()
		require("render-markdown").setup()
		vim.keymap.set(
			"n",
			"<leader>mr",
			"<cmd>RenderMarkdown toggle<cr>",
			{ desc = "Toggle Markdown rendering (render-markdown)" }
		)
	end,
}
