return {
    {
        -- inline image rendering in markdown buffers
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
