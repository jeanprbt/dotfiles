return {
    "folke/noice.nvim",
    keys = {
        { "<leader>sn", false },
        { "<leader>sna", false },
        { "<leader>snd", false },
        { "<leader>snh", false },
        { "<leader>snl", false },
        { "<leader>snt", false },
    },
    opts = {
        routes = {
            {
                filter = {
                    event = "msg_show",
                    kind = "",
                    find = "written",
                },
                opts = { skip = true },
            },
        },
    },
}
