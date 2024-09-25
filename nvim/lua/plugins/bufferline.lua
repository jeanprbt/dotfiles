return {
	"akinsho/bufferline.nvim",
	event = "ColorScheme",
	opts = function()
		local selected = "#faf4ed"
		local visible = "#f2e9e1"
		if vim.o.background == "dark" then
			selected = "#232136"
			visible = "#393552"
		end
		return {
			options = {
				offsets = {
					{
						filetype = "NvimTree",
						text = "File Explorer",
						highlight = "Directory",
						text_align = "center",
					},
				},
			},
			highlights = {
				fill = {
					bg = selected,
				},
				background = {
					bg = visible,
				},
				close_button_selected = {
					bg = selected,
				},
				close_button_visible = {
					bg = visible,
				},
				close_button = {
					bg = visible,
				},
				buffer_selected = {
					bg = selected,
				},
				buffer_visible = {
					bg = visible,
				},
				modified_selected = {
					bg = selected,
				},
				modified_visible = {
					bg = visible,
				},
				modified = {
					bg = visible,
				},
				separator_selected = {
					bg = selected,
				},
				separator_visible = {
					bg = visible,
				},
				separator = {
					bg = visible,
				},
				indicator_selected = {
					bg = selected,
				},
				indicator_visible = {
					bg = visible,
				},
				offset_separator = {
					bg = visible,
				},
			},
		}
	end,
	config = function(_, opts)
		require("bufferline").setup(opts)
		vim.keymap.set("n", "<Tab>", "<cmd>BufferLineCycleNext<cr>", { desc = "switch to next tab (bufferline)" })
		vim.keymap.set(
			"n",
			"<leader>ct",
			"<cmd>BufferLineCloseOthers<cr>",
			{ desc = "_c_lose other _t_abs (bufferline)" }
		)
	end,
}
