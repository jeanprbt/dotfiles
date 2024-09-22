return {
	"mfussenegger/nvim-dap",
	ft = { "python" },
	dependencies = {
		{
			"rcarriga/nvim-dap-ui",
			opts = {
				layouts = {
					{
						elements = {
							{
								id = "scopes",
								size = 0.5,
							},
							{
								id = "breakpoints",
								size = 0.25,
							},
							{
								id = "watches",
								size = 0.25,
							},
						},
						position = "left",
						size = 40,
					},
					{
						elements = {
							"repl",
						},
						position = "bottom",
						size = 10,
					},
				},
			},
		},
		{
			"jay-babu/mason-nvim-dap.nvim",
			opts = {
				ensure_installed = {
					"python",
					"delve",
				},
			},
		},
		{
			"mfussenegger/nvim-dap-python",
			ft = "python",
			config = function()
				require("dap-python").setup("~/.local/share/nvim/mason/packages/debugpy/venv/bin/python")
			end,
		},
		{
			"leoluz/nvim-dap-go",
			ft = "go",
			opts = {},
		},
		"williamboman/mason.nvim",
		"nvim-neotest/nvim-nio",
	},
	config = function()
		local dap = require("dap")
		local open = function()
			require("dapui").open()
		end
		local close = function()
			require("dapui").close()
		end
		dap.listeners.before.attach.dapui_config = open
		dap.listeners.before.launch.dapui_config = open
		dap.listeners.before.event_terminated.dapui_config = close
		dap.listeners.before.event_exited.dapui_config = close

		local sign = vim.fn.sign_define
		sign("DapBreakpoint", { text = "●", texthl = "DapBreakpoint", linehl = "", numhl = "" })
		sign("DapBreakpointCondition", { text = "●", texthl = "DapBreakpointCondition", linehl = "", numhl = "" })
		sign("DapLogPoint", { text = "◆", texthl = "DapLogPoint", linehl = "", numhl = "" })
		sign("DapStopped", { text = "", texthl = "", linehl = "DiffText", numhl = "" })

		vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, { desc = "Add breakpoint (dap)" })
		vim.keymap.set("n", "<leader>dl", dap.continue, { desc = "Launch/Resume debugging session (dap)" })
		vim.keymap.set("n", "<leader>di", dap.step_into, { desc = "Step into current instruction (dap)" })
		vim.keymap.set("n", "<leader>ds", dap.step_over, { desc = "Step over one instruction (dap)" })
	end,
}
