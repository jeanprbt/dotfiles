return {
	{
		"zbirenbaum/copilot.lua",
		cmd = "Copilot",
		event = "InsertEnter",
		opts = function()
			vim.keymap.set("n", "<leader>cp", "<cmd>Copilot toggle<cr>", { desc = "toggle _c_o_p_ilot (copilot)" })
			return {
				panel = {
					enabled = false,
				},
				suggestion = {
					auto_trigger = true,
					keymap = {
						accept = false,
						accept_word = false,
						accept_line = false,
						dismiss = "<C-e>",
					},
				},
				filetypes = {
					markdown = true,
				},
			}
		end,
	},
	{
		"CopilotC-Nvim/CopilotChat.nvim",
		branch = "canary",
		dependencies = {
			{ "zbirenbaum/copilot.lua" },
			{ "nvim-lua/plenary.nvim" },
		},
		build = "make tiktoken",
		opts = {
			question_header = " Me ",
			show_help = false,
			window = {
				width = 0.25,
				border = "none",
			},
		},
		config = function(_, opts)
			require("CopilotChat").setup(opts)
			require("CopilotChat.integrations.cmp").setup()
			vim.keymap.set(
				{ "n", "v" },
				"<leader>cc",
				"<cmd>CopilotChatToggle<cr>",
				{ desc = "toggle _c_opilot _c_hat (copilot)" }
			)
			vim.keymap.set(
				"n",
				"<leader>cr",
				"<cmd>CopilotChatReset<cr>",
				{ desc = "make a _c_opilot chat _r_eset (copilot)" }
			)
		end,
	},
}
