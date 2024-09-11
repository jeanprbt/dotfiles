return {
	{
		"nvim-telescope/telescope-media-files.nvim",
		dependencies = {
			"nvim-lua/popup.nvim",
		},
		config = function()
			require("telescope").load_extension("media_files")
		end,
	},
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.8",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		config = function()
			local builtin = require("telescope.builtin")
			local actions = require("telescope.actions")
			vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Find file (telescope)" })
			vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Grep string (telescope)" })
			require("telescope").setup({
				defaults = {
					mappings = {
						i = {
							["<esc>"] = actions.close,
							["<C-S-k>"] = actions.move_selection_previous,
							["<C-S-j>"] = actions.move_selection_next,
						},
					},
				},
				extensions = {
					media_files = {
						filetypes = { "png", "webp", "jpg", "jpeg" },
					},
				},
			})
		end,
	},
}
