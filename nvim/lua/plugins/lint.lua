return {
	"mfussenegger/nvim-lint",
	event = {
		"BufReadPre",
		"BufNewFile",
	},
	dependencies = {
		"williamboman/mason.nvim",
		{
			"rshkarin/mason-nvim-lint",
			opts = {
				ensure_installed = {
					"ruff",
					"golangci-lint",
				},
			},
		},
	},
	config = function()
		local lint = require("lint")
		vim.keymap.set("n", "<leader>l", function()
			lint.try_lint()
		end, { desc = "Lint file (lint)" })
		vim.api.nvim_create_autocmd({ "BufWritePost", "InsertLeave" }, {
			callback = function()
				lint.try_lint()
			end,
		})
		lint.linters_by_ft = {
			python = { "ruff" },
			go = { "golangcilint" },
		}
		lint.linters.golangcilint.args = {
			"run",
			"--out-format",
			"json",
		}
	end,
}
