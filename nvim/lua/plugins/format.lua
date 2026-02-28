return {
    {
        "stevearc/conform.nvim",
        dependencies = {
            "mason-org/mason.nvim",
            {
                "zapling/mason-conform.nvim",
                config = true,
            },
        },
        event = {
            "BufReadPre",
            "BufNewFile",
        },
        keys = {
            { "<leader>cF", false },
        },
        opts = function()
            vim.keymap.set("n", "<leader>cf", function()
                require("conform").format({ bufnr = 0 })
            end, { desc = "_c_ode _f_ormat" })
            return {
                formatters_by_ft = {
                    lua = { "stylua" },
                    python = { "ruff" },
                    json = { "jq" },
                },
                formatters = {
                    jq = {
                        command = "jq",
                        args = { "--indent", "4" },
                    },
                },
            }
        end,
    },
}
