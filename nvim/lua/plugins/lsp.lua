return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			{
				"williamboman/mason.nvim",
				config = true,
			},
			{
				"williamboman/mason-lspconfig.nvim",
				opts = {
					ensure_installed = {
						"lua_ls",
						"pyright",
					},
				},
			},
			"hrsh7th/cmp-nvim-lsp",
		},
		config = function()
			local capabilities = vim.lsp.protocol.make_client_capabilities()
			capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())
			local lspconfig = require("lspconfig")
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
			vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Show code actions (lsp)" })
		end,
	},
	{
		"smjonas/inc-rename.nvim",
		opts = function()
			vim.keymap.set("n", "<leader>rn", ":IncRename ", { desc = "Rename occurences (inc-rename)" })
			return {}
		end,
	},
}
