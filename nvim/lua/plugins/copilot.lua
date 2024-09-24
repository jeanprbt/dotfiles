return {
	"zbirenbaum/copilot.lua",
	cmd = "Copilot",
	event = "InsertEnter",
	opts = function()
		vim.keymap.set("n", "<leader>tc", "<cmd>Copilot toggle<cr>", { desc = "_t_oggle _c_opilot (copilot)" })
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
		}
	end,
}
