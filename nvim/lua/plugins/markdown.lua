return {
    {
        "MeanderingProgrammer/render-markdown.nvim",
        ft = { "markdown" },
        opts = {
            file_types = { "markdown" },
        },
        config = function(_, opts)
            require("render-markdown").setup(opts)
            vim.keymap.set(
                "n",
                "<leader>mr",
                "<cmd>RenderMarkdown toggle<cr>",
                { desc = "toggle _m_arkdown _r_endering" }
            )
        end,
    },
}
