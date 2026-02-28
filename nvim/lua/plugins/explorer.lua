return {
    "nvim-neo-tree/neo-tree.nvim",
    opts = {
        window = {
            mappings = {
                ["<space>"] = "open",
            },
        },
        filesystem = {
            filtered_items = {
                visible = true,
            },
        },
    },
    keys = function()
        return {
            {
                "<leader><space>",
                function()
                    require("neo-tree.command").execute({ toggle = true })
                end,
                desc = "toggle explorer",
            },
            {
                "<leader>;",
                function()
                    require("neo-tree.command").execute({ focus = true })
                end,
                desc = "focus explorer",
            },
        }
    end,
}
