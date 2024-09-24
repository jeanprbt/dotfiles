return {
	"folke/noice.nvim",
	event = "VeryLazy",
	dependencies = {
		{
			"rcarriga/nvim-notify",
			opts = {
				background_colour = "#1e222a",
				render = "wrapped-compact",
				stages = "fade",
				timeout = 2000,
			},
			config = function(_, opts)
				local notify = require("notify")
				notify.setup(opts)
				vim.notify = notify
			end,
		},
		"MunifTanjim/nui.nvim",
	},
	config = function()
		require("noice").setup({
			lsp = {
				override = {
					["vim.lsp.util.convert_input_to_markdown_lines"] = true,
					["vim.lsp.util.stylize_markdown"] = true,
					["cmp.entry.get_documentation"] = true,
				},
			},
			presets = {
				bottom_search = false,
				command_palette = true,
				long_message_to_split = true,
				inc_rename = true,
				lsp_doc_border = true,
			},
		})
	end,
}
