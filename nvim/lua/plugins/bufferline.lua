return {
	"akinsho/bufferline.nvim",
	event = "ColorScheme",
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	opts = function()
		local highlights = require("rose-pine.plugins.bufferline")
		return {
			highlights = highlights,
			options = {
				diagnostics = "nvim_lsp",
				diagnostics_indicator = function(count, level)
					local icon = level:match("error") and " " or " "
					return " " .. icon .. count
				end,
				color_icons = true,
				show_buffer_icons = true,
				offsets = { { filetype = "NvimTree", text = "File Explorer", text_align = "center" } },
			},
		}
	end,
	config = function(_, opts)
		require("bufferline").setup(opts)
		vim.keymap.set("n", "<Tab>", "<cmd>BufferLineCycleNext<cr>", { desc = "switch to next tab (bufferline)" })
		vim.keymap.set(
			"n",
			"<leader>ct",
			"<cmd>BufferLineCloseOthers<cr>",
			{ desc = "_c_lose other _t_abs (bufferline)" }
		)
	end,
}
