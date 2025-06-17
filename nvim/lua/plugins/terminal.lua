return {
	"akinsho/toggleterm.nvim",
	version = "*",
	dependencies = {
		"fouladi/toggle-overlength.nvim", -- ensure <leader>th shortcut is deleted --
	},
	opts = function()
		local highlights = require("rose-pine.plugins.toggleterm")
		return {
			open_mapping = "<C-t>",
			highlights = highlights,
			float_opts = {
				border = "curved",
			},
		}
	end,
	config = function(_, opts)
		local toggleterm = require("toggleterm")
		local terms = require("toggleterm.terminal")
		toggleterm.setup(opts)
		vim.keymap.set("t", "<esc>", [[<C-\><C-n>]], { desc = "exit terminal mode (toggleterm)" })

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
		vim.keymap.set("n", "<leader>lg", "<cmd>lua _lazygit_toggle()<cr>", { desc = "open _l_azy_g_it (toggleterm)" })
		vim.keymap.set(
			"n",
			"<leader>ht",
			"<cmd>ToggleTerm size=15 direction=horizontal<cr>",
			{ desc = "open _h_orizontal _t_erminal (toggleterm)" }
		)
		vim.keymap.set(
			"n",
			"<leader>pt",
			"<cmd>lua _python_toggle()<cr>",
			{ desc = "open _p_ython _t_erminal (toggleterm)" }
		)
		vim.keymap.set(
			"n",
			"<leader>vt",
			"<cmd>ToggleTerm size=50 direction=vertical<cr>",
			{ desc = "open _v_ertical _t_erminal (toggleterm)" }
		)
		vim.keymap.set(
			"n",
			"<leader>wt",
			"<cmd>ToggleTerm direction=float<cr>",
			{ desc = "open _w_indow _t_erminal (toggleterm)" }
		)
		function _G.open_next_terminal()
			local terminals = terms.get_all()
			local direction = terminals[1].direction
			Terminal:new({
				close_on_exit = true,
				direction = direction,
			}):toggle()
		end
		vim.api.nvim_set_keymap(
			"n",
			"<leader>nt",
			"<cmd>lua open_next_terminal()<cr>",
			{ desc = "open _n_ext _t_erminal (toggleterm)" }
		)
	end,
}
