return {
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
}
