return {
	"zbirenbaum/copilot.lua",
	cmd = "Copilot",
	event = "InsertEnter",
	config = function()
		require("copilot").setup({
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
		})
		vim.keymap.set("n", "<leader>cp", "<cmd>Copilot toggle<cr>", { desc = "Toggle Copilot (copilot)" })
	end,
}
