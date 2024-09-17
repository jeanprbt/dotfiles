return {
	"mfussenegger/nvim-lint",
	dependencies = {
		"williamboman/mason.nvim",
		{
			"rshkarin/mason-nvim-lint",
			opts = {
				ensure_installed = {
					"flake8",
				},
			},
		},
	},
	event = {
		"BufReadPre",
		"BufNewFile",
	},
	config = function()
		local lint = require("lint")
		vim.api.nvim_create_autocmd({ "BufWritePost" }, {
			callback = function()
				require("lint").try_lint()
			end,
		})
		vim.keymap.set("n", "<leader>l", function()
			require("lint").try_lint()
		end, { desc = "Lint file (lint)" })

		lint.linters_by_ft = {
			python = { "flake8" },
		}
		lint.linters.flake8.args = {
			"--max-line-length=120",
		}
	end,
}
