return {
	{
		"neovim/nvim-lspconfig",

		dependencies = {
			{
				"williamboman/mason.nvim",
				opts = {
					ui = {
						keymaps = {
							apply_language_filter = "F",
						},
					},
				},
			},
			{
				"williamboman/mason-lspconfig.nvim",
				opts = {
					ensure_installed = {
						"lua_ls",
						"jsonls",
						"ty",
					},
					automatic_enable = false,
				},
			},
			"hrsh7th/cmp-nvim-lsp",
		},
		config = function()
			local capabilities = require("cmp_nvim_lsp").default_capabilities()
			vim.lsp.config("*", {
				capabilities = capabilities,
			})
			vim.lsp.enable("lua_ls")
			vim.lsp.enable("jsonls")
			vim.lsp.enable("ty")
			vim.keymap.set("n", "H", vim.lsp.buf.hover, { desc = "show _H_over information (lsp)" })
			vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "_g_o to _d_efinition (lsp)" })
			vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "show _c_ode _a_ctions (lsp)" })
		end,
	},
	{
		"smjonas/inc-rename.nvim",
		opts = function()
			vim.keymap.set("n", "<leader>rn", ":IncRename ", { desc = "_r_e_n_ame occurences (inc-rename)" })
			return {}
		end,
	},
}
