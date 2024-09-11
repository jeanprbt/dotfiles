function NewFileWithPrompt()
	vim.ui.input({ prompt = "New filename: " }, function(input)
		if input and input ~= "" then
			vim.cmd("edit " .. input)
		end
	end)
end

vim.cmd("command! DashboardNewFile :enew")
vim.cmd("command! DashboardNewFile lua NewFileWithPrompt()")

return {
	"nvimdev/dashboard-nvim",
	event = "VimEnter",
	config = function()
		require("dashboard").setup({
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
						desc = " Recents",
						group = "@property",
						action = "Telescope oldfiles",
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
		})
	end,
	dependencies = { { "nvim-tree/nvim-web-devicons" } },
}
