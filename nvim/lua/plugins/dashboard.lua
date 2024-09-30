return {
	"nvimdev/dashboard-nvim",
	event = "VimEnter",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	opts = function()
		vim.api.nvim_create_user_command("DashboardNewFile", function()
			vim.ui.input({ prompt = "New filename: " }, function(input)
				if input and input ~= "" then
					vim.cmd("edit " .. input)
				end
			end)
		end, {})
		vim.api.nvim_create_user_command("DashboardOpenFolder", function()
			vim.cmd("enew")
			vim.cmd("NvimTreeFocus")
		end, {})
		return {
			theme = "hyper",
			config = {
				week_header = {
					enable = true,
				},
				shortcut = {
					{
						desc = " Extensions",
						group = "@property",
						action = "Lazy",
						key = "l",
					},
					{
						desc = "󰊳 LSP",
						group = "@property",
						action = "Mason",
						key = "m",
					},
					{
						desc = " New File",
						group = "@property",
						action = "DashboardNewFile",
						key = "n",
					},
					{
						desc = " Find Files",
						group = "@property",
						action = "Telescope find_files",
						key = "f",
					},
					{
						desc = " Folder",
						group = "@property",
						action = "DashboardOpenFolder",
						key = "a",
					},
					{
						desc = " Config",
						group = "@property",
						action = "Telescope find_files cwd=~/.config/nvim",
						key = "c",
					},
					{
						desc = " Exit",
						group = "@property",
						action = "exit",
						key = "q",
					},
				},
				project = {
					enable = true,
					limit = 4,
				},
			},
		}
	end,
}
