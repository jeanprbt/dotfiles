return {
	"mfussenegger/nvim-dap",
	ft = { "python" },
	dependencies = {
		{
			"rcarriga/nvim-dap-ui",
			config = true,
		},
		{
			"jay-babu/mason-nvim-dap.nvim",
			opts = {
				ensure_installed = {
					"python",
				},
			},
		},
		"mfussenegger/nvim-dap-python",
		"williamboman/mason.nvim",
		"nvim-neotest/nvim-nio",
	},
	config = function()
		local dap = require("dap")
		local open = function()
			require("dapui").open()
		end
		dap.listeners.before.attach.dapui_config = open
		dap.listeners.before.launch.dapui_config = open
		dap.listeners.before.event_terminated.dapui_config = open
		dap.listeners.before.event_exited.dapui_config = open

		local sign = vim.fn.sign_define
		sign("DapBreakpoint", { text = "●", texthl = "DapBreakpoint", linehl = "", numhl = "" })
		sign("DapBreakpointCondition", { text = "●", texthl = "DapBreakpointCondition", linehl = "", numhl = "" })
		sign("DapLogPoint", { text = "◆", texthl = "DapLogPoint", linehl = "", numhl = "" })

		vim.keymap.set("n", "<leader>b", dap.toggle_breakpoint, { desc = "Add breakpoint (dap)" })
		vim.keymap.set("n", "<leader>a", dap.continue, { desc = "Launch/Resume debugging session (dap)" })
		vim.keymap.set("n", "<leader>i", dap.step_into, { desc = "Step into current instruction (dap)" })
		vim.keymap.set("n", "<leader>e", dap.step_over, { desc = "Step over one instruction (dap)" })

		require("dap-python").setup("~/.local/share/nvim/mason/packages/debugpy/venv/bin/python")
	end,
}
