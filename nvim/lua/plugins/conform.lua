return {
	"stevearc/conform.nvim",
	dependencies = {
		"williamboman/mason.nvim",
		"zapling/mason-conform.nvim",
	},
	event = {
		"BufReadPre",
		"BufNewFile",
	},
	config = function()
		require("conform").setup({
			formatters_by_ft = {
				lua = { "stylua" },
			},
			format_on_save = {
				timeout_ms = 500,
				lsp_format = "fallback",
			},
		})
		require("mason-conform").setup()
		vim.keymap.set("n", "<leader>ft", function()
			require("conform").format({ bufnr = 0 })
		end, { desc = "Format file (conform)" })
	end,
}
