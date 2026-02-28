local pink = "#ea9a97"
return {
    {
        "nvim-lualine/lualine.nvim",
        opts = function()
            -- PERF: we don't need this lualine require madness 🤷
            local lualine_require = require("lualine_require")
            lualine_require.require = require

            local icons = LazyVim.config.icons

            vim.o.laststatus = vim.g.lualine_laststatus

            local opts = {
                options = {
                    theme = "rose-pine",
                    section_separators = { left = "", right = "" },
                    component_separators = { left = "•", right = "•" },
                    globalstatus = vim.o.laststatus == 3,
                    disabled_filetypes = { statusline = { "dashboard", "alpha", "ministarter", "snacks_dashboard" } },
                },
                sections = {
                    lualine_a = { "mode" },
                    lualine_b = { "branch" },
                    lualine_c = {
                        {
                            "diagnostics",
                            symbols = {
                                error = icons.diagnostics.Error,
                                warn = icons.diagnostics.Warn,
                                info = icons.diagnostics.Info,
                                hint = icons.diagnostics.Hint,
                            },
                        },
                        { "filename" },
                    },
                    lualine_x = {
                        {
                            function()
                                local path = require("venv-selector").venv()
                                local last_slash = path:match(".*()/")
                                return "venv : " .. (last_slash and path:sub(last_slash + 1) or path)
                            end,
                            icon = { "", color = { fg = pink } },
                            cond = function()
                                return (os.getenv("VIRTUAL_ENV") ~= nil) and vim.bo.filetype == "python"
                            end,
                            on_click = function()
                                vim.cmd("VenvSelect")
                            end,
                        },
                        {
                            function()
                                return "  " .. require("dap").status()
                            end,
                            cond = function()
                                return package.loaded["dap"] and require("dap").status() ~= ""
                            end,
                            color = function()
                                return { fg = Snacks.util.color("Debug") }
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
                        { "progress", padding = { left = 1, right = 1 } },
                    },
                    lualine_z = {
                        { "location", padding = { left = 1, right = 1 } },
                    },
                },
                extensions = { "neo-tree", "lazy", "fzf" },
            }

            -- do not add trouble symbols if aerial is enabled
            -- And allow it to be overriden for some buffer types (see autocmds)
            if vim.g.trouble_lualine and LazyVim.has("trouble.nvim") then
                local trouble = require("trouble")
                local symbols = trouble.statusline({
                    mode = "symbols",
                    groups = {},
                    title = false,
                    filter = { range = true },
                    format = "{kind_icon}{symbol.name:Normal}",
                    hl_group = "lualine_c_normal",
                })
                table.insert(opts.sections.lualine_c, {
                    symbols and symbols.get,
                    cond = function()
                        return vim.b.trouble_lualine ~= false and symbols.has()
                    end,
                })
            end

            return opts
        end,
    },
}
