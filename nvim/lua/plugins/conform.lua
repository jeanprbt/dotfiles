return {
	"stevearc/conform.nvim",
	dependencies = {
		"williamboman/mason.nvim",
		{
			"zapling/mason-conform.nvim",
			config = true,
		},
	},
	event = {
		"BufReadPre",
		"BufNewFile",
	},
	opts = function()
		vim.keymap.set("n", "<leader>ft", function()
			require("conform").format({ bufnr = 0 })
		end, { desc = "_f_orma_t_ file (conform)" })
		return {
			formatters_by_ft = {
				lua = { "stylua" },
				go = { "gofumpt", "golines" },
				python = { "black" },
			},
			format_on_save = {
				timeout_ms = 500,
				lsp_format = "fallback",
			},
		}
	end,
}
