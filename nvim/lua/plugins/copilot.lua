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
		dependencies = {
			{ "zbirenbaum/copilot.lua" },
			{ "nvim-lua/plenary.nvim" },
		},
		build = "make tiktoken",
		opts = {
			question_header = " Me ",
			answer_header = " Copilot ",
			show_help = false,
			chat_autocomplete = true,
			window = {
				width = 0.25,
				border = "none",
			},
		},
		config = function(_, opts)
			require("CopilotChat").setup(opts)
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
