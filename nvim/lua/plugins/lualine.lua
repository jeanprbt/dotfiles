return {
	"nvim-lualine/lualine.nvim",
	event = "ColorScheme",
	dependencies = {
		"nvim-tree/nvim-web-devicons",
		"AndreM222/copilot-lualine",
		"nvimtools/hydra.nvim",
		"benlubas/molten-nvim",
		"linux-cultist/venv-selector.nvim",
	},
	opts = function()
		local pink = "#ea9a97"
		local blue = "#9ccfd8"
		return {
			options = {
				theme = "rose-pine",
				section_separators = { left = "", right = "" },
				component_separators = { left = "•", right = "•" },
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
							if require("hydra.statusline").is_active() then
								return "NOTEBOOK"
							else
								return modes[vim.fn.mode()]
							end
						end,
						color = function()
							if require("hydra.statusline").is_active() then
								return { bg = blue, gui = "bold" }
							else
								return { gui = "bold" }
							end
						end,
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
				},
				lualine_c = {
					{
						"filename",
						cond = function()
							return not require("hydra.statusline").is_active()
						end,
					},
					{
						function()
							local hydra = require("hydra.statusline")
							if hydra.is_active() then
								return hydra.get_hint()
							end
						end,
						cond = function()
							return require("hydra.statusline").is_active()
						end,
					},
				},
				lualine_x = {
					{
						"copilot",
						symbols = {
							status = {
								hl = {
									enabled = pink,
									sleep = pink,
									disabled = pink,
									warning = pink,
									unknown = pink,
								},
							},
						},
						show_colors = true,
					},
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
							return "kernel : " .. require("molten.status").kernels()
						end,
						icon = { "", color = { fg = pink } },
						cond = function()
							return require("molten.status").initialized() == "Molten" and vim.bo.filetype == "markdown"
						end,
						on_click = function()
							vim.cmd("MoltenDeinit")
							vim.cmd("MoltenInit")
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
								if client.name ~= "copilot" then
									table.insert(client_names, client.name)
								end
							end
							return table.concat(client_names, ", ")
						end,
						icon = { "󱉶", color = { fg = pink } },
						cond = function()
							return require("molten.status").initialized() ~= "Molten"
						end,
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
						cond = function()
							return require("molten.status").initialized() ~= "Molten"
						end,
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
						cond = function()
							return require("molten.status").initialized() ~= "Molten"
						end,
					},
					"filetype",
				},
				lualine_y = {
					{
						"progress",
						color = function()
							if require("hydra.statusline").is_active() then
								return { fg = blue }
							end
						end,
					},
				},
				lualine_z = {
					{
						"location",
						color = function()
							if require("hydra.statusline").is_active() then
								return { bg = blue, gui = "bold" }
							else
								return { gui = "bold" }
							end
						end,
					},
				},
			},
			extensions = {
				"nvim-tree",
				"trouble",
				"lazy",
				"mason",
				"nvim-dap-ui",
				"toggleterm",
			},
		}
	end,
}
