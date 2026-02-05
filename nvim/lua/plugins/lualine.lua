return {
	"nvim-lualine/lualine.nvim",
	event = "ColorScheme",
	dependencies = {
		"nvim-tree/nvim-web-devicons",
		"linux-cultist/venv-selector.nvim",
	},
	opts = function()
		local pink = "#ea9a97"
		return {
			options = {
				theme = "rose-pine",
				section_separators = { left = "", right = "" },
				component_separators = { left = "•", right = "•" },
				disabled_filetypes = { "neotest-summary" },
			},
			sections = {
				lualine_a = {
					{
						function()
							local modes = {
								n = "NORMAL",
								i = "INSERT",
								c = "COMMAND",
								V = "V-LINE",
								v = "VISUAL",
								R = "REPLACE",
								s = "SELECT",
								S = "S-LINE",
								t = "TERMINAL",
							}
							return modes[vim.fn.mode()]
						end,
						color = { gui = "bold" },
						separator = { right = "" },
					},
				},
				lualine_b = {
					{
						function()
							return vim.g.remote_neovim_host and vim.uv.os_gethostname() or ""
						end,
						icon = { "", color = { fg = pink } },
						padding = { right = 1, left = 1 },
						separator = { left = "", right = "" },
					},
					"diagnostics",
				},
				lualine_c = {
					{
						"filename",
					},
				},
				lualine_x = {
					{
						function()
							local path = require("venv-selector").venv()
							local last_slash = path:match(".*()/")
							local conda = false
							if string.find(path, "conda") then
								conda = true
							end
							if not last_slash then
								return conda and "conda : " .. path or "venv : " .. path
							else
								return conda and "conda : " .. path:sub(last_slash + 1)
									or "venv : " .. path:sub(last_slash + 1)
							end
						end,
						icon = { "", color = { fg = pink } },
						cond = function()
							return (os.getenv("VIRTUAL_ENV") ~= nil or os.getenv("CONDA_PREFIX") ~= nil)
								and vim.bo.filetype == "python"
						end,
						on_click = function()
							vim.cmd("VenvSelect")
						end,
					},
					{
						function()
							local clients = vim.lsp.get_clients({ bufnr = 0 })
							if #clients == 0 then
								return ""
							end
							local client_names = {}
							for _, client in pairs(clients) do
								table.insert(client_names, client.name)
							end
							return table.concat(client_names, ", ")
						end,
						icon = { "󱉶", color = { fg = pink } },
					},
					{
						function()
							local lint = require("lint")
							local client_names = {}
							local cur_ft = vim.bo.filetype
							for ft, ft_linters in pairs(lint.linters_by_ft) do
								if ft == cur_ft then
									if type(ft_linters) == "table" then
										for _, linter in pairs(ft_linters) do
											table.insert(client_names, linter)
										end
									else
										table.insert(client_names, ft_linters)
									end
								end
							end
							if #client_names == 0 then
								return ""
							end
							return table.concat(client_names, ", ")
						end,
						icon = { "󱨍", color = { fg = pink } },
					},
					{
						function()
							local conform = require("conform")
							local client_names = {}
							for _, formatter in pairs(conform.list_formatters_for_buffer(0)) do
								if formatter then
									table.insert(client_names, formatter)
								end
							end
							if #client_names == 0 then
								return ""
							end
							return table.concat(client_names, ", ")
						end,
						icon = { "󰛖", color = { fg = pink } },
					},
					"filetype",
				},
				lualine_y = {
					{
						"progress",
					},
				},
				lualine_z = {
					{
						"location",
						color = { gui = "bold" },
					},
				},
			},
			extensions = {
				"nvim-tree",
				"trouble",
				"lazy",
				"mason",
				"toggleterm",
			},
		}
	end,
}
