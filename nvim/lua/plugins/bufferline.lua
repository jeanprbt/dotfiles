return {
	"akinsho/bufferline.nvim",
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	config = function()
		require("bufferline").setup({
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
			highlights = require("catppuccin.groups.integrations.bufferline").get(),
		})
		vim.keymap.set("n", "<Tab>", "<cmd>BufferLineCycleNext<cr>", { desc = "Switch to next tab (bufferline)" })
		vim.keymap.set("n", "<leader>w", "<cmd>BufferLineCloseOthers<cr>", { desc = "Close other tabs (bufferline)" })
	end,
}
