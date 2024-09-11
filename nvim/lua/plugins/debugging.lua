return {

	"mfussenegger/nvim-dap",
	dependencies = {
		"williamboman/mason.nvim",
		"jay-babu/mason-nvim-dap.nvim",
		"rcarriga/nvim-dap-ui",
		"nvim-neotest/nvim-nio",
		"mfussenegger/nvim-dap-python",
	},
	config = function()
		require("dapui").setup({})

		require("dap").listeners.before.attach.dapui_config = function()
			require("dapui").open()
		end
		require("dap").listeners.before.launch.dapui_config = function()
			require("dapui").open()
		end
		require("dap").listeners.before.event_terminated.dapui_config = function()
			require("dapui").close()
		end
		require("dap").listeners.before.event_exited.dapui_config = function()
			require("dapui").close()
		end

		require("mason-nvim-dap").setup({
			ensure_installed = {
				"python",
			},
		})

		local sign = vim.fn.sign_define

		sign("DapBreakpoint", { text = "●", texthl = "DapBreakpoint", linehl = "", numhl = "" })
		sign("DapBreakpointCondition", { text = "●", texthl = "DapBreakpointCondition", linehl = "", numhl = "" })
		sign("DapLogPoint", { text = "◆", texthl = "DapLogPoint", linehl = "", numhl = "" })

		vim.keymap.set("n", "<leader>b", require("dap").toggle_breakpoint, { desc = "Add breakpoint (dap)" })
		vim.keymap.set("n", "<leader>a", require("dap").continue, { desc = "Launch/Resume debugging session (dap)" })
		vim.keymap.set("n", "<leader>i", require("dap").step_into, { desc = "Step into current instruction (dap)" })
		vim.keymap.set("n", "<leader>e", require("dap").step_over, { desc = "Step over one instruction (dap)" })

		require("dap-python").setup("~/.local/share/nvim/mason/packages/debugpy/venv/bin/python")
	end,
}
