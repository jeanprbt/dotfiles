return {
	"linux-cultist/venv-selector.nvim",
	dependencies = {
		"neovim/nvim-lspconfig",
		"mfussenegger/nvim-dap",
		"mfussenegger/nvim-dap-python",
		{ "nvim-telescope/telescope.nvim", branch = "0.1.x", dependencies = { "nvim-lua/plenary.nvim" } },
	},
	lazy = false,
	branch = "regexp",
	opts = function()
		return {
			settings = {
				options = {
					on_telescope_result_callback = function(filename)
						return filename
							:gsub(os.getenv("HOME") .. "/.", "")
							:gsub("/bin/python", "")
							:gsub("/opt/homebrew/Caskroom/", "")
							:gsub("/base/envs", "")
					end,
				},
				search = {
					virtualenvs = {
						command = "fd /bin/python$ ~/.virtualenvs --full-path --color never",
					},
					anaconda_base = {
						command = "fd /python$ /opt/homebrew/Caskroom/miniconda/base/bin --full-path --color never",
						type = "anaconda",
					},
					anaconda_envs = {
						command = "fd bin/python$ /opt/homebrew/Caskroom/miniconda/base/envs/ --full-path --color never",
						type = "anaconda",
					},
				},
			},
		}
	end,
	config = function(_, opts)
		local venv = require("venv-selector")
		venv.setup(opts)
		vim.keymap.set("n", "<leader>sv", "<cmd>VenvSelect<cr>", { desc = "_s_elect python _v_env (venv-selector)" })
		vim.keymap.set("n", "<leader>dv", venv.deactivate, { desc = "_d_eactivate python _v_env (venv-selector)" })
	end,
}
