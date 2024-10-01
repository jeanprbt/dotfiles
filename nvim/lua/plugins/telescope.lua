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
		opts = function()
			local actions = require("telescope.actions")
			return {
				defaults = {
					mappings = {
						i = {
							["<esc>"] = actions.close,
							["<Tab>"] = actions.move_selection_next,
						},
					},
				},
				extensions = {
					media_files = {
						filetypes = { "png", "webp", "jpg", "jpeg" },
					},
				},
			}
		end,
		config = function(_, opts)
			require("telescope").setup(opts)
			local builtin = require("telescope.builtin")
			vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "_f_ind _f_ile (telescope)" })
			vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "_f_ind _g_rep string (telescope)" })
			vim.keymap.set("n", "<leader>fu", builtin.lsp_references, { desc = "_f_ind _u_sages (telescope)" })
		end,
	},
}
