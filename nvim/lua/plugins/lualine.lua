local pink = "#ea9a97"
return {
    {
        "nvim-lualine/lualine.nvim",
        dependencies = {
            "nvimtools/hydra.nvim",
            "benlubas/molten-nvim",
        },
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
                                local hydra_active = false
                                local ok, hydra = pcall(require, "hydra.statusline")
                                if ok then
                                    hydra_active = hydra.is_active()
                                end
                                if hydra_active then
                                    return "NOTEBOOK"
                                else
                                    return modes[vim.fn.mode()]
                                end
                            end,
                            color = function()
                                local hydra_active = false
                                local ok, hydra = pcall(require, "hydra.statusline")
                                if ok then
                                    hydra_active = hydra.is_active()
                                end
                                if hydra_active then
                                    return { bg = "orange", gui = "bold" }
                                else
                                    return { gui = "bold" }
                                end
                            end,
                            separator = { right = "" },
                        },
                    },
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
                            cond = function()
                                return not require("hydra.statusline").is_active()
                            end,
                        },
                        {
                            "filename",
                            path = 1,
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
                            function()
                                local path = os.getenv("VIRTUAL_ENV")
                                local last_slash = path:match(".*()/")
                                return (last_slash and path:sub(last_slash + 1) or path)
                            end,
                            icon = { "", color = { fg = pink } },
                            cond = function()
                                return (os.getenv("VIRTUAL_ENV") ~= nil)
                                    and vim.bo.filetype == "python"
                                    and not require("molten.status").initialized() == "Molten"
                            end,
                            on_click = function()
                                vim.cmd("VenvSelect")
                            end,
                        },
                        {
                            function()
                                return "kernel : " .. require("molten.status").kernels()
                            end,
                            icon = { "", color = { fg = "green" } },
                            cond = function()
                                return require("molten.status").initialized() == "Molten"
                                    and (vim.bo.filetype == "markdown" or vim.bo.filetype == "ipynb")
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
                                    if client.name ~= "ruff" then
                                        table.insert(client_names, client.name)
                                    end
                                end
                                return table.concat(client_names, ", ")
                            end,
                            icon = { "󱉶", color = { fg = pink } },
                            cond = function()
                                return not (
                                    require("molten.status").initialized() == "Molten"
                                    and vim.bo.filetype == "markdown"
                                )
                            end,
                        },
                        {
                            function()
                                local conform = require("conform")
                                local client_names = {}
                                local has_ruff = false
                                for _, formatter in pairs(conform.list_formatters_for_buffer(0)) do
                                    if formatter and formatter:match("^ruff") then
                                        has_ruff = true
                                    elseif formatter then
                                        table.insert(client_names, formatter)
                                    end
                                end
                                if has_ruff then
                                    table.insert(client_names, "ruff")
                                end
                                if #client_names == 0 then
                                    return ""
                                end
                                return table.concat(client_names, ", ")
                            end,
                            icon = { "󰛖", color = { fg = pink } },
                            cond = function()
                                return not (
                                    require("molten.status").initialized() == "Molten"
                                    and vim.bo.filetype == "markdown"
                                )
                            end,
                        },
                    },
                    lualine_y = {
                        {
                            "progress",
                            padding = { left = 1, right = 1 },
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
                            padding = { left = 1, right = 1 },
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
