return {
	"folke/which-key.nvim",
	opts = {
		plugins = {
			marks = false,
		},
		win = {
			border = "rounded",
		},
	},
	config = function(_, opts)
		local wk = require("which-key")
		wk.setup(opts)
		wk.add({
			{
				"<leader>?",
				function()
					wk.show()
				end,
				desc = "Show key bindings (which-key)",
			},
			{
				"<leader>,",
				"<cmd>Telescope find_files cwd=~/.config/nvim<cr>",
				desc = "Open config (which-key)",
			},
			{
				"<M-Up>",
				"<cmd>m -2<CR>==",
				desc = "Move line up (which-key)",
			},
			{
				"<M-Down>",
				"<cmd>m +1<CR>==",
				desc = "Move line down (which-key)",
			},
		})
	end,
}
