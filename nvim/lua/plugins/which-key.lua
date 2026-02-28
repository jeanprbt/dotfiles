return {
    "folke/which-key.nvim",
    opts = function(_, opts)
        opts.spec = {
            mode = { "n", "x" },
            { "<leader>c", group = "code" },
            { "<leader>f", group = "file/find" },
            { "<leader>g", group = "git" },
            { "<leader>q", group = "quit/session" },
            { "<leader>s", group = "search" },
            { "<leader>e", group = "enable" },
            { "<leader>t", group = "trouble" },
            { "[", group = "prev" },
            { "]", group = "next" },
            { "g", group = "goto" },
            { "z", group = "fold" },
            {
                "<leader>b",
                group = "buffer",
                expand = function()
                    return require("which-key.extras").expand.buf()
                end,
            },
            {
                "<leader>w",
                group = "windows",
                proxy = "<c-w>",
                expand = function()
                    return require("which-key.extras").expand.win()
                end,
            },
        }
    end,
}
