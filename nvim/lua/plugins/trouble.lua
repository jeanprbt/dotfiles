return {
    {
        "folke/trouble.nvim",
        keys = {
            { "<leader>xx", false },
            { "<leader>xX", false },
            { "<leader>cs", false },
            { "<leader>cS", false },
            { "<leader>xL", false },
            { "<leader>xQ", false },
            { "<leader>td", "<cmd>Trouble diagnostics toggle<cr>", desc = "_t_rouble _d_iagnostics" },
        },
    },
    {
        "folke/todo-comments.nvim",
        cmd = { "TodoTrouble", "TodoTelescope" },
        event = "LazyFile",
        opts = {},
        keys = {
            { "]t", false },
            { "[t", false },
            { "<leader>xT", false },
            { "<leader>sT", false },
            { "<leader>st", false },
            { "<leader>xt", false },
            { "<leader>tt", "<cmd>Trouble todo toggle<cr>", desc = "_t_rouble _t_o-do" },
        },
    },
}
