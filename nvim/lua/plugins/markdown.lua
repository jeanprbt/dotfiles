return {
	{
		"MeanderingProgrammer/render-markdown.nvim",
		dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
		opts = {
			file_types = { "markdown", "copilot-chat" },
		},
		config = function(_, opts)
			require("render-markdown").setup(opts)
			vim.keymap.set(
				"n",
				"<leader>mr",
				"<cmd>RenderMarkdown toggle<cr>",
				{ desc = "toggle _m_arkdown _r_endering (render-markdown)" }
			)
		end,
	},
	{
		"iamcco/markdown-preview.nvim",
		cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
		build = "cd app && npm install",
		init = function()
			vim.g.mkdp_filetypes = { "markdown" }
			vim.cmd([[do FileType]])
			vim.cmd([[
                function OpenMarkdownPreview (url)
                    let cmd = "kitten @ goto-layout splits & kitten @ launch --location vsplit --keep-focus awrit " . shellescape(a:url)
                    silent call system(cmd)
                endfunction
            ]])
			vim.g.mkdp_browserfunc = "OpenMarkdownPreview"
			vim.keymap.set(
				"n",
				"<leader>mp",
				"<cmd>MarkdownPreviewToggle<cr>",
				{ desc = "toggle _m_arkdown _p_review in browser (markdown-preview)" }
			)
			local function load_then_exec(cmd)
				return function()
					vim.cmd.delcommand(cmd)
					require("lazy").load({ plugins = { "markdown-preview.nvim" } })
					vim.api.nvim_exec_autocmds("BufEnter", {})
					vim.cmd(cmd)
				end
			end

			for _, cmd in pairs({ "MarkdownPreviewToggle" }) do
				vim.api.nvim_create_user_command(cmd, load_then_exec(cmd), {})
			end
		end,
	},
	{
		"jbyuki/nabla.nvim",
		config = function()
			local nabla = require("nabla")
			vim.keymap.set("n", "<leader>mn", function()
				nabla.toggle_virt()
			end, { desc = "toggle _m_arkdown _n_abla (nabla)" })
		end,
	},
}
