return {
	"nvim-treesitter/nvim-treesitter",
	dependencies = {
		"nvim-treesitter/nvim-treesitter-textobjects",
	},
	lazy = false,
	build = ":TSUpdate",
	config = function()
		local config = require("nvim-treesitter.configs")
		config.setup({
			ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "javascript", "python", "java", "markdown" },
			sync_install = false,
			auto_install = true,
			modules = {},
			ignore_install = {},
			highlight = { enable = true },
			indent = { enable = true },
			textobjects = {
				move = {
					enable = true,
					set_jumps = false,
					goto_next_start = {
						["J"] = {
							query = "@block.inner",
							desc = "move to next code block (treesitter)",
						},
					},
					goto_previous_start = {
						["K"] = {
							query = "@block.inner",
							desc = "move to previous code block (treesitter)",
						},
					},
				},
				select = {
					enable = true,
					lookahead = true,
					keymaps = {
						["ib"] = { query = "@block.inner", desc = "cell block" },
						["ab"] = { query = "@block.outer", desc = "cell block" },
					},
				},
				swap = {
					enable = true,
					swap_next = {
						["sn"] = {
							query = "@block.outer",
							desc = "_s_wap with _n_ext code block (treesitter)",
						},
					},
					swap_previous = {
						["sp"] = {
							query = "@block.outer",
							desc = "_s_wap with _p_revious code block (treesitter)",
						},
					},
				},
			},
		})
	end,
}
