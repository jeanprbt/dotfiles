local function my_on_attach(bufnr)
	local api = require("nvim-tree.api")

	local function opts(desc)
		return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
	end

	api.config.mappings.default_on_attach(bufnr)

	vim.keymap.set("n", ".", api.tree.change_root_to_node, opts("Change root to node"))
	vim.keymap.set("n", "i", api.node.show_info_popup, opts("Show info popup"))
	vim.keymap.set("n", "<Space>", api.node.open.edit, opts("Open"))
end

return {
	"nvim-tree/nvim-tree.lua",
	version = "*",
	lazy = false,
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	config = function()
		require("nvim-tree").setup({
			on_attach = my_on_attach,
		})
		vim.keymap.set("n", "<leader><Space>", "<cmd>NvimTreeToggle<cr>", { desc = "Toggle file explorer (nvim-tree)" })
		vim.keymap.set("n", "<leader>;", "<cmd>NvimTreeFocus<cr>", { desc = "Focus file explorer (nvim-tree)" })
	end,
}
