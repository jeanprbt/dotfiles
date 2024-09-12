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
	config = function()
		local venv = require("venv-selector")
		local function shorter_name(filename)
			return filename
				:gsub(os.getenv("HOME") .. "/.", "")
				:gsub("/bin/python", "")
				:gsub("/opt/homebrew/Caskroom/", "")
				:gsub("/base/envs", "")
		end
		venv.setup({
			settings = {
				options = {
					on_telescope_result_callback = shorter_name,
				},
				search = {
					virtualenvs = {
						command = "fd /bin/python$ ~/.virtualenvs --full-path --color never",
					},
					anaconda_base = {
						command = "fd python$ /opt/homebrew/Caskroom/miniconda/base/bin --full-path --color never",
						type = "anaconda",
					},
					anaconda_envs = {
						command = "fd bin/python$ /opt/homebrew/Caskroom/miniconda/base/envs/ --full-path --color never",
						type = "anaconda",
					},
				},
			},
		})

		vim.keymap.set(
			"n",
			"<leader>vs",
			"<cmd>VenvSelect<cr>",
			{ desc = "Select python virtual env. (venv-selector)" }
		)
		vim.keymap.set("n", "<leader>vd", venv.deactivate, { desc = "Deactivate python virtual env. (venv-selector)" })
	end,
}
