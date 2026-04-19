return {
    {
        "3rd/image.nvim",
        build = false,
        opts = {
            processor = "magick_cli",
            max_width = 100,
            max_height = 12,
            max_height_window_percentage = math.huge,
            max_width_window_percentage = math.huge,
            window_overlap_clear_enabled = true,
            window_overlap_clear_ft_ignore = { "cmp_menu", "cmp_docs", "" },
        },
    },
    {
        "benlubas/molten-nvim",
        version = "^1.0.0",
        dependencies = { "3rd/image.nvim" },
        build = ":UpdateRemotePlugins",
        init = function()
            vim.g.molten_image_provider = "image.nvim"
            vim.g.molten_output_win_max_height = 20
            vim.g.molten_auto_open_output = false
            vim.g.molten_wrap_output = true
            vim.g.molten_virt_text_output = true
        end,
        config = function()
            local default_notebook = [[
  {
    "cells": [
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
                else
                    print("Error: Could not open new notebook file for writing.")
                end
            end

            vim.api.nvim_create_user_command("NewNotebook", function(opts)
                new_notebook(opts.args)
            end, {
                nargs = 1,
                complete = "file",
            })

            -- automatically import output chunks from a jupyter notebook
            -- registers a kernel from the active venv if available, otherwise falls back to kernel picker
            local imb = function(e) -- init molten buffer
                vim.schedule(function()
                    local venv = os.getenv("VIRTUAL_ENV")
                    if venv then
                        local kernel_name = venv:gsub("/$", ""):match(".+/([^/]+)/[^/]+$") or "python3"
                        vim.fn.system({ venv .. "/bin/python", "-m", "ipykernel", "install", "--user", "--name", kernel_name })
                        vim.cmd(("MoltenInit %s"):format(kernel_name))
                        vim.cmd("MoltenImportOutput")
                    else
                        local kernels = vim.fn.MoltenAvailableKernels()
                        vim.ui.select(kernels, { prompt = "Select kernel:" }, function(choice)
                            if choice then
                                vim.cmd("MoltenInit " .. choice)
                                vim.cmd("MoltenImportOutput")
                            end
                        end)
                    end

                    -- buffer-local jupyter keymaps
                    local buf = e.buf
                    local o = { buffer = buf, silent = true }
                    vim.keymap.set(
                        "n",
                        "<leader>jo",
                        ":noautocmd MoltenEnterOutput<CR>",
                        vim.tbl_extend("force", o, { desc = "enter _j_upyter _o_utput" })
                    )
                    vim.keymap.set(
                        "n",
                        "<leader>jh",
                        ":MoltenHideOutput<CR>",
                        vim.tbl_extend("force", o, { desc = "_j_upyter _h_ide output" })
                    )
                    local runner = require("quarto.runner")
                    vim.keymap.set(
                        "n",
                        "<leader>jr",
                        runner.run_cell,
                        vim.tbl_extend("force", o, { desc = "_j_upyter _r_un cell" })
                    )
                    vim.keymap.set(
                        "n",
                        "<leader>ja",
                        runner.run_above,
                        vim.tbl_extend("force", o, { desc = "_j_upyter run _a_bove" })
                    )
                    vim.keymap.set(
                        "n",
                        "<leader>jA",
                        runner.run_all,
                        vim.tbl_extend("force", o, { desc = "_j_upyter run _a_ll cells" })
                    )
                    vim.keymap.set(
                        "n",
                        "<leader>jl",
                        runner.run_line,
                        vim.tbl_extend("force", o, { desc = "_j_upyter run _l_ine" })
                    )
                    vim.keymap.set(
                        "v",
                        "<leader>jv",
                        runner.run_range,
                        vim.tbl_extend("force", o, { desc = "_j_upyter run _v_isual" })
                    )
                end)
            end

            -- automatically import output chunks from a jupyter notebook
            vim.api.nvim_create_autocmd("BufAdd", {
                pattern = { "*.ipynb" },
                callback = imb,
            })

            -- we have to do this as well so that we catch files opened like nvim ./hi.ipynb
            vim.api.nvim_create_autocmd("BufEnter", {
                pattern = { "*.ipynb" },
                callback = function(e)
                    if vim.api.nvim_get_vvar("vim_did_enter") ~= 1 then
                        imb(e)
                    end
                end,
            })

            -- automatically export output chunks to a jupyter notebook on write
            vim.api.nvim_create_autocmd("BufWritePost", {
                pattern = { "*.ipynb" },
                callback = function()
                    local ok, molten_status = pcall(require, "molten.status")
                    if ok and molten_status.initialized() == "Molten" then
                        -- pcall: molten may error on certain output types (nbformat bug)
                        pcall(vim.cmd, "MoltenExportOutput!")
                    end
                end,
            })
        end,
    },
    {
        "jmbuhr/otter.nvim",
        opts = {
            buffers = {
                write_to_disk = true,
            },
            lsp = {
                diagnostic_update_events = { "BufWritePost", "InsertLeave", "TextChanged" },
            },
        },
    },
    {
        "quarto-dev/quarto-nvim",
        ft = { "quarto", "markdown" },
        dependencies = {
            "jmbuhr/otter.nvim",
            "nvim-treesitter/nvim-treesitter",
            "neovim/nvim-lspconfig",
            "mason-org/mason-lspconfig.nvim",
        },
        opts = {
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
                rename = "<leader>cr",
                references = "sr",
                format = "<leader>cf",
            },
            codeRunner = {
                enabled = true,
                default_method = "molten",
            },
        },
    },
    {
        "GCBallesteros/jupytext.nvim",
        opts = {
            style = "markdown",
            output_extension = "md",
            force_ft = "markdown",
        },
    },
    {
        "nvimtools/hydra.nvim",
        config = function()
            local function keys(str)
                return function()
                    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(str, true, false, true), "m", true)
                end
            end

            local function new_cell()
                if vim.fn.search("```", "W") == 0 then
                    vim.cmd("normal! G")
                end
                vim.cmd("normal! o")
                vim.cmd("normal! o```python")
                vim.cmd("normal! o")
                vim.cmd("normal! o```")
                vim.cmd("normal! k")
                keys("q")()
                keys("i")()
            end

            local Hydra = require("hydra")
            local notebook = Hydra({
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
                -- body = "<leader>jn",
                heads = {
                    { "j", keys("]b") },
                    { "k", keys("[b") },
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

            -- HACK: patch for https://github.com/nvimtools/hydra.nvim/issues/71
            -- util.deepcopy breaks _G.Hydra assignment for pink hydras via setfenv
            notebook.layer._hydra = notebook
            local sl = require("hydra.statusline")
            local _get_hint = sl.get_hint
            sl.get_hint = function()
                local hydra = _G.Hydra or (_G.active_keymap_layer and _G.active_keymap_layer._hydra)
                if not hydra then
                    return
                end
                local hint_type = hydra.config.hint and hydra.config.hint.type
                if hydra.config.hint == false or hint_type == "statuslinemanual" or hint_type == "statusline" then
                    return hydra.hint:show(true)
                end
                return _get_hint()
            end

            vim.keymap.set("n", "<leader>jn", function()
                if require("molten.status").initialized() == "Molten" then
                    notebook:activate()
                else
                    vim.notify("Notebook mode is only available for *.ipynb files.")
                end
            end, { desc = "_j_upyter _n_otebook mode" })
        end,
    },
    {
        "nvim-treesitter/nvim-treesitter-textobjects",
        branch = "main",
        event = "VeryLazy",
        opts = {
            move = {
                enable = true,
                set_jumps = true,
                keys = {
                    goto_next_start = {
                        ["]b"] = "@code_cell.inner",
                    },
                    goto_previous_start = {
                        ["[b"] = "@code_cell.inner",
                    },
                },
            },
        },
    },
}
