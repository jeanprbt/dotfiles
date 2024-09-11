return {
	"mfussenegger/nvim-lint",
	dependencies = {
		"williamboman/mason.nvim",
		"rshkarin/mason-nvim-lint",
	},
	event = {
		"BufReadPre",
		"BufNewFile",
	},
	config = function()
		require("lint").linters_by_ft = {
			python = { "flake8" },
		}
		require("mason-nvim-lint").setup({
			ensure_installed = {
				"flake8",
			},
		})
		vim.api.nvim_create_autocmd({ "BufWritePost" }, {
			callback = function()
				require("lint").try_lint()
			end,
		})
		vim.keymap.set("n", "<leader>l", function()
			require("lint").try_lint()
		end, { desc = "Lint file (lint)" })
	end,
}
