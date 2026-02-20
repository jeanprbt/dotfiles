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
						"yamlls",
						"taplo",
						"ty",
					},
					automatic_enable = false,
				},
			},
			"hrsh7th/cmp-nvim-lsp",
			"b0o/schemastore.nvim",
		},
		config = function()
			local capabilities = require("cmp_nvim_lsp").default_capabilities()
			vim.lsp.config("*", {
				capabilities = capabilities,
			})
			vim.lsp.enable("lua_ls")
			vim.lsp.enable("jsonls")
			vim.lsp.config("jsonls", {
				settings = {
					json = {
						schemas = require("schemastore").json.schemas(),
						validate = { enable = true },
					},
				},
			})
			vim.lsp.enable("yamlls")
			vim.lsp.config("yamlls", {
				settings = {
					yaml = {
						schemaStore = {
							enable = false,
							url = "",
						},
						schemas = require("schemastore").yaml.schemas(),
					},
				},
			})
			vim.lsp.enable("taplo")
			vim.lsp.config("taplo", {
				settings = {
					evenBetterToml = {
						schema = {
							associations = {
								["example\\.toml$"] = "https://json.schemastore.org/example.json",
							},
						},
					},
				},
			})
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
