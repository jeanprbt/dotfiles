return {
    {
        "nvim-lualine/lualine.nvim",
        opts = function()
            -- PERF: we don't need this lualine require madness 🤷
            local lualine_require = require("lualine_require")
            lualine_require.require = require

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
                                return modes[vim.fn.mode()]
                            end,
                            color = { gui = "bold" },
                            separator = { right = "" },
                        },
                    },
                    lualine_b = { "branch" },
                    lualine_c = {
                        {
                            "filename",
                            path = 1,
                        },
                    },
                    lualine_x = { "filetype" },
                    lualine_y = {
                        {
                            "progress",
                            padding = { left = 1, right = 1 },
                        },
                    },
                    lualine_z = {
                        {
                            "location",
                            padding = { left = 1, right = 1 },
                            color = { gui = "bold" },
                        },
                    },
                },
                extensions = { "neo-tree", "lazy" },
            }

            return opts
        end,
    },
}
