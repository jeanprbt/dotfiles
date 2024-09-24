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
		vim.keymap.set("n", "<leader>lt", function()
			lint.try_lint()
		end, { desc = "_l_in_t_ file (nvim-lint)" })
		vim.api.nvim_create_autocmd({ "BufWritePost" }, {
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
