local function lsp_clients()
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
end

local function linters()
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
end

local function formatters()
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
end

return {
	"nvim-lualine/lualine.nvim",
	dependencies = {
		"nvim-tree/nvim-web-devicons",
		"AndreM222/copilot-lualine",
	},
	config = function()
		require("lualine").setup({
			options = {
				theme = "catppuccin",
				section_separators = { left = "", right = "" },
				component_separators = { left = "", right = "" },
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
							local hydra = require("hydra.statusline")
							if hydra.is_active() then
								return "NOTEBOOK"
							else
								return modes[vim.fn.mode()]
							end
						end,
						color = function()
							if require("hydra.statusline").is_active() then
								return { bg = "orange", gui = "bold" }
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
						icon = { "", color = { fg = "pink" } },
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
									enabled = "#89b4fa",
									sleep = "#89b4fa",
								},
							},
						},
						show_colors = true,
					},
					{
						lsp_clients,
						icon = { "", color = { fg = "beige" } },
					},
					{
						linters,
						icon = { "", color = { fg = "yellow" } },
					},
					{
						formatters,
						icon = { "󰛖", color = { fg = "pink" } },
					},
					{
						function()
							return "kernel : " .. require("molten.status").kernels()
						end,
						icon = { "", color = { fg = "green" } },
						cond = function()
							return (vim.bo.filetype == "markdown" or vim.bo.filetype == "quarto")
								and require("molten.status").initialized()
						end,
					},
					"filetype",
				},
				lualine_y = {
					{
						"progress",
						color = function()
							if require("hydra.statusline").is_active() then
								return { fg = "orange" }
							end
						end,
					},
				},
				lualine_z = {
					{
						"location",
						color = function()
							if require("hydra.statusline").is_active() then
								return { bg = "orange", gui = "bold" }
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
		})
	end,
}
