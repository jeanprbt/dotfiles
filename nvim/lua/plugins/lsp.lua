return {
	"neovim/nvim-lspconfig",
	dependencies = {
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		"hrsh7th/cmp-nvim-lsp",
	},
	config = function()
		require("mason-lspconfig").setup({
			ensure_installed = {
				"lua_ls",
				"pyright",
				settings = {
					python = {
						analysis = {
							diagnosticSeverityOverrides = {
								reportUnusedExpression = "none",
							},
						},
					},
				},
			},
		})

		local lspconfig = require("lspconfig")
		local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())

		lspconfig.lua_ls.setup({
			capabilities = capabilities,
		})
		lspconfig.pyright.setup({
			capabilities = capabilities,
			filetypes = { "python" },
			settings = {
				python = {
					analysis = {
						diagnosticSeverityOverrides = {
							reportUnusedExpression = "none",
						},
					},
				},
			},
		})
		vim.keymap.set("n", "H", vim.lsp.buf.hover, { desc = "Show hover information (lsp)" })
		vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition (lsp)" })
		vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Rename occurences (lsp)" })
		vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Show code actions (lsp)" })
	end,
}
