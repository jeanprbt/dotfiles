return {
	{
		"nvim-neotest/neotest",
		ft = { "go" },
		dependencies = {
			"nvim-neotest/nvim-nio",
			"nvim-lua/plenary.nvim",
			"antoinemadec/FixCursorHold.nvim",
			"nvim-treesitter/nvim-treesitter",
			{
				"fredrikaverpil/neotest-golang",
				dependencies = {
					"leoluz/nvim-dap-go",
				},
			},
		},
		opts = function()
			return {
				adapters = {
					require("neotest-golang")({
						testify_enabled = true,
						runner = "gotestsum",
					}),
				},
				summary = {
					enabled = true,
					animated = true,
					expand_errors = true,
					mappings = {
						expand = "<CR>",
						expand_all = "<Space>",
						output = "o",
						jumpto = "i",
						run = "r",
						mark = "m",
						run_marked = "M",
						clear_marked = "c",
					},
				},
				icons = {
					passed = " ",
					running = " ",
					failed = " ",
				},
				output = {
					open_on_run = true,
				},
			}
		end,
		config = function(_, opts)
			local neotest = require("neotest")
			neotest.setup(opts)

			vim.keymap.set("n", "<leader>nt", function()
				neotest.run.run()
			end, { desc = "run _n_earest _t_est (neotest)" })

			vim.keymap.set("n", "<leader>dt", function()
				neotest.run.run({ suite = false, strategy = "dap" })
			end, { desc = "_d_ebug nearest _t_est (neotest)" })

			vim.keymap.set("n", "<leader>ts", function()
				neotest.summary.toggle()
			end, { desc = "toggle _t_est _s_ummary (neotest)" })

			vim.keymap.set("n", "<leader>ft", function()
				neotest.run.run(vim.fn.expand("%"))
			end, { desc = "run _f_ile _t_est (neotest)" })

			vim.keymap.set("n", "<leader>to", function()
				neotest.output.open()
			end, { desc = "open _t_est _o_utput (neotest) " })

			vim.keymap.set("n", "<leader>at", function()
				---@diagnostic disable-next-line: undefined-field
				neotest.run.run(vim.uv.cwd())
			end, { desc = "run _a_ll _t_ests (neotest)" })
		end,
	},
}
