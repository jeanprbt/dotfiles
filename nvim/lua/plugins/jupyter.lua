return {
	{
		"benlubas/molten-nvim",
		dependencies = {
			{
				"3rd/image.nvim",
				event = "VeryLazy",
				config = function()
					require("image").setup({
						backend = "kitty",
						integrations = {
							markdown = {
								enabled = true,
								only_render_image_at_cursor = true,
								filetypes = { "markdown", "quarto" },
							},
						},
						max_width = 100,
						max_height = 12,
						max_height_window_percentage = math.huge,
						max_width_window_percentage = math.huge,
						window_overlap_clear_enabled = true,
						window_overlap_clear_ft_ignore = { "cmp_menu", "cmp_docs", "" },
						window_background_opacity = 100,
					})
				end,
			},

			"GCBallesteros/jupytext.nvim",
			"nvimtools/hydra.nvim",
		},
		build = ":UpdateRemotePlugins",
		config = function()
			vim.g.molten_auto_open_output = false
			vim.g.molten_image_provider = "image.nvim"
			vim.g.molten_output_win_max_height = 20
			vim.g.molten_wrap_output = true
			vim.g.molten_virt_text_output = true
			vim.g.molten_virt_lines_off_by_1 = true
			require("jupytext").setup({
				style = "markdown",
				output_extension = "md",
				force_ft = "markdown",
			})

			local imb = function()
				vim.schedule(function()
					local kernels = vim.fn.MoltenAvailableKernels()
					local kernel_name = nil
					if not ok or not vim.tbl_contains(kernels, kernel_name) then
						kernel_name = nil
						local venv = os.getenv("VIRTUAL_ENV")
						local conda_env = os.getenv("CONDA_DEFAULT_ENV")
						if venv ~= nil then
							kernel_name = string.match(venv, "/.+/(.+)")
						elseif conda_env ~= nil then
							kernel_name = conda_env
						end
					end
					if kernel_name ~= nil and vim.tbl_contains(kernels, kernel_name) then
						vim.cmd(("MoltenInit %s"):format(kernel_name))
					end
					vim.cmd("MoltenImportOutput")
				end)
			end

			vim.api.nvim_create_autocmd("BufAdd", {
				pattern = { "*.ipynb" },
				callback = imb,
			})

			vim.api.nvim_create_autocmd("BufEnter", {
				pattern = { "*.ipynb" },
				callback = function(e)
					if vim.api.nvim_get_vvar("vim_did_enter") ~= 1 then
						imb()
					end
				end,
			})

			vim.api.nvim_create_autocmd("BufWritePost", {
				pattern = { "*.ipynb" },
				callback = function()
					if require("molten.status").initialized() == "Molten" then
						vim.cmd("MoltenExportOutput!")
					end
				end,
			})

			local default_notebook = [[
                {
                    "cells": [
                        {
                            "cell_type": "code",
                            "execution_count": null,
                            "metadata": {},
                            "outputs": [],
                            "source": []
                        },
                        {
                            "cell_type": "markdown",
                            "metadata": {},
                            "source": [
                                ""
                            ]
                        }
                    ],
                    "metadata": {
                        "kernelspec": {
                            "display_name": "Python 3",
                            "language": "python",
                            "name": "python3"
                        },
                        "language_info": {
                            "codemirror_mode": {
                                "name": "ipython"
                            },
                            "file_extension": ".py",
                            "mimetype": "text/x-python",
                            "name": "python",
                            "nbconvert_exporter": "python",
                            "pygments_lexer": "ipython3"
                        }
                    },
                    "nbformat": 4,
                    "nbformat_minor": 5
                }
            ]]

			local function new_notebook(filename)
				local path = filename .. ".ipynb"
				local file = io.open(path, "w")
				if file then
					file:write(default_notebook)
					file:close()
					vim.cmd("edit " .. path)
					require("quarto").activate()
				else
					print("Error: Could not open new notebook file for writing.")
				end
			end

			vim.api.nvim_create_user_command("MoltenNewNotebook", function(opts)
				new_notebook(opts.args)
			end, {
				nargs = 1,
				complete = "file",
			})

			local function keys(str)
				return function()
					vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(str, true, false, true), "m", true)
				end
			end

			local function new_cell()
				vim.cmd("/```")
				vim.cmd("normal! o")
				vim.cmd("normal! o```python")
				vim.cmd("normal! o")
				vim.cmd("normal! o```")
				vim.cmd("normal! k")
				keys("q")()
				keys("i")()
			end

			local hydra = require("hydra")
			hydra({
				name = "Notebook",
				hint = "_j_  | _k_  | _r_  | _R_  | _a_  | _s_  | _c_  | _o_  | _h_  | _n_  | _<esc>_/_q_ 󰩈",
				config = {
					color = "pink",
					invoke_on_body = true,
					hint = {
						type = "statuslinemanual",
					},
				},
				mode = { "n" },
				body = "<leader>n",
				heads = {
					{
						"j",
						function()
							keys("J")()
							keys("zz")()
						end,
					},
					{
						"k",
						function()
							keys("K")()
							keys("zz")()
						end,
					},
					{ "r", ":QuartoSend<cr>" },
					{ "R", ":QuartoSendAll<cr>" },
					{ "a", ":MoltenInterrupt<cr>" },
					{ "s", ":MoltenRestart!<cr>" },
					{ "o", ":noautocmd MoltenEnterOutput<cr>" },
					{ "h", ":MoltenHideOutput<cr>" },
					{ "c", ":MoltenDelete<cr>" },
					{ "n", new_cell },
					{ "<esc>", nil, { exit = true } },
					{ "q", nil, { exit = true } },
				},
			})
		end,
	},
	{
		"quartodev/quarto-nvim",
		ft = { "quarto", "markdown" },
		dependencies = {
			"jmbuhr/otter.nvim",
			"nvim-treesitter/nvim-treesitter",
		},
		config = function()
			local quarto = require("quarto")
			quarto.setup({
				lspFeatures = {
					languages = { "python" },
					chunks = "all",
					diagnostics = {
						enabled = true,
						triggers = { "BufWritePost" },
					},
					completion = {
						enabled = true,
					},
				},
				keymap = {
					hover = "K",
					definition = "gd",
					rename = "<leader>rn",
					references = "<leader>rf",
					format = "<leader>ft",
				},
				codeRunner = {
					enabled = true,
					default_method = "molten",
				},
			})
		end,
	},
}
