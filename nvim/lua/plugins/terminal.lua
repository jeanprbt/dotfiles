return {
	"akinsho/toggleterm.nvim",
	version = "*",
	dependencies = {
		"fouladi/toggle-overlength.nvim", -- ensure <leader>th shortcut is deleted --
	},
	opts = {
		open_mapping = "<C-t>",
		float_opts = {
			border = "curved",
		},
	},
	config = function(_, opts)
		local toggleterm = require("toggleterm")
		local terms = require("toggleterm.terminal")
		toggleterm.setup(opts)

		local Terminal = terms.Terminal
		function _G._lazygit_toggle()
			Terminal:new({
				cmd = "lazygit",
				direction = "float",
				close_on_exit = true,
				float_opts = { border = "curved" },
			}):toggle()
		end
		function _G._python_toggle()
			Terminal:new({
				cmd = "python3",
				direction = "horizontal",
				close_on_exit = true,
			}):toggle()
		end
		vim.keymap.set("n", "<leader>tg", "<cmd>lua _lazygit_toggle()<cr>", { desc = "Open lazygit (toggleterm)" })
		vim.keymap.set(
			{ "n", "t" },
			"<leader>th",
			"<cmd>ToggleTerm size=15 direction=horizontal<cr>",
			{ desc = "Open horizontal terminal (toggleterm)" }
		)
		vim.keymap.set(
			"n",
			"<leader>tp",
			"<cmd>lua _python_toggle()<cr>",
			{ desc = "Open python terminal (toggleterm)" }
		)
		vim.keymap.set(
			{ "n", "t" },
			"<leader>tv",
			"<cmd>ToggleTerm size=50 direction=vertical<cr>",
			{ desc = "Open vertical terminal (toggleterm)" }
		)
		vim.keymap.set(
			{ "n", "t" },
			"<leader>tf",
			"<cmd>ToggleTerm direction=float<cr>",
			{ desc = "Open float terminal (toggleterm)" }
		)
		function _G.set_terminal_keymaps()
			vim.keymap.set("t", "<esc>", [[<C-\><C-n>]], { desc = "Exit terminal mode (toggleterm)" })
			vim.keymap.set({ "n", "t" }, "<C-h>", [[<Cmd>wincmd h<cr>]], { desc = "Move to left window (toggleterm)" })
			vim.keymap.set({ "n", "t" }, "<C-j>", [[<Cmd>wincmd j<cr>]], { desc = "Move to below window (toggleterm)" })
			vim.keymap.set({ "n", "t" }, "<C-k>", [[<Cmd>wincmd k<cr>]], { desc = "Move to above window (toggleterm)" })
			vim.keymap.set({ "n", "t" }, "<C-l>", [[<Cmd>wincmd l<cr>]], { desc = "Move to right window (toggleterm)" })
		end
		function _G.open_next_terminal()
			local terminals = terms.get_all()
			local direction = terminals[1].direction
			Terminal:new({
				close_on_exit = true,
				direction = direction,
			}):toggle()
		end
		vim.api.nvim_set_keymap(
			"t",
			"<leader>tt",
			"<cmd>lua open_next_terminal()<cr>",
			{ noremap = true, silent = true }
		)
		vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")
	end,
}
