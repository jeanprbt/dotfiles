return {
	"nvim-tree/nvim-tree.lua",
	version = "*",
	lazy = false,
	dependencies = {
		"b0o/nvim-tree-preview.lua",
		"nvim-tree/nvim-web-devicons",
	},
	opts = {
		on_attach = function(bufnr)
			local api = require("nvim-tree.api")
			local function opts(desc)
				return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
			end
			api.config.mappings.default_on_attach(bufnr)

			local preview = require("nvim-tree-preview")
			vim.keymap.set("n", "<Tab>", function()
				local ok, node = pcall(api.tree.get_node_under_cursor)
				if ok and node then
					if node.type == "directory" then
						api.node.open.edit()
					else
						preview.node(node, { toggle_focus = true })
					end
				end
			end, opts("Preview"))
			vim.keymap.set("n", ".", api.tree.change_root_to_node, opts("Change root to node"))
			vim.keymap.set("n", "i", api.node.show_info_popup, opts("Show info pop up"))
			vim.keymap.set("n", "<Space>", api.node.open.edit, opts("Open"))
		end,
	},
	config = function(_, opts)
		require("nvim-tree").setup(opts)
		vim.keymap.set("n", "<leader><Space>", "<cmd>NvimTreeToggle<cr>", { desc = "toggle file explorer (nvim-tree)" })
		vim.keymap.set("n", "<leader>;", "<cmd>NvimTreeFocus<cr>", { desc = "focus file explorer (nvim-tree)" })
	end,
}
