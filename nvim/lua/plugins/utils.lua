return {
	{
		"3rd/image.nvim",
		event = "VeryLazy",
		opts = {
			backend = "kitty",
			integrations = {
				markdown = {
					enabled = true,
					only_render_image_at_cursor = true,
					filetypes = { "markdown" },
				},
			},
			max_width = 100,
			max_height = 12,
			max_height_window_percentage = math.huge,
			max_width_window_percentage = math.huge,
			window_overlap_clear_enabled = true,
			window_overlap_clear_ft_ignore = { "cmp_menu", "cmp_docs", "" },
			window_background_opacity = 100,
		},
	},
	{
		"echasnovski/mini.pairs",
		config = true,
	},
	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		opts = {
			scope = {
				enabled = false,
			},
			exclude = {
				filetypes = {
					"NvimTree",
					"Lazy",
					"Mason",
					"dashboard",
					"help",
					"lspinfo",
					"man",
					"Trouble",
					"gitcommit",
					"TelescopePrompt",
					"TelescopeResults",
					"''",
				},
				buftypes = {
					"terminal",
					"nofile",
					"quickfix",
					"prompt",
				},
			},
		},
	},
	{
		"stevearc/dressing.nvim",
		event = "VeryLazy",
		config = true,
	},
	{
		"mrjones2014/smart-splits.nvim",
		build = "./kitty/install-kittens.bash",
		opts = {},
	},
	{
		"fouladi/toggle-overlength.nvim",
		opts = function()
			local color
			if vim.o.background == "dark" then
				color = "#56526e"
			else
				color = "#cecacd"
			end
			return {
				guibg = color,
			}
		end,
		config = function(_, opts)
			require("toggle-overlength").setup(opts)
			vim.keymap.del("n", "<leader>th")
			vim.keymap.set(
				"n",
				"<leader>ol",
				"<cmd>ToggleHiOverLength<cr>",
				{ desc = "toggle _o_ver_l_ength line (toggle-overlength)" }
			)
		end,
	},
	{
		"VonHeikemen/searchbox.nvim",
		dependencies = {
			"MunifTanjim/nui.nvim",
		},
		config = function()
			vim.keymap.set("n", "<leader>sr", function()
				require("searchbox").replace({ show_matches = "[{total}]", confirm = "menu" })
			end, { desc = "_s_earch & _r_eplace (searchbox)" })
			vim.keymap.set("v", "<leader>sr", function()
				require("searchbox").replace({
					visual_mode = true,
					show_matches = "[{total}]",
					confirm = "menu",
				})
			end, { desc = "_s_earch & _r_eplace (searchbox)" })
		end,
	},
}
