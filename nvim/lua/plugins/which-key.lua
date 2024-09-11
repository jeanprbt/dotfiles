return {
	"folke/which-key.nvim",
	config = function()
		local wk = require("which-key")
		vim.keymap.set("v", "<C-c>", '"+y', { desc = "Copy to clipboard (which-key)" })
		wk.setup({
			plugins = {
				marks = false,
			},
			win = {
				border = "rounded",
			},
		})
		wk.add({
			{
				"<leader>?",
				function()
					wk.show()
				end,
				desc = "Show key bindings (which-key)",
			},
			{
				"<leader>j",
				":m .+1<cr>==",
				desc = "Move line down (which-key)",
			},
			{
				"<leader>k",
				":m .-2<cr>==",
				desc = "Move line up (which-key)",
			},
			{
				"<leader>,",
				"<cmd>Telescope find_files cwd=~/.config/nvim<cr>",
				desc = "Open config (which-key)",
			},
		})
	end,
}
