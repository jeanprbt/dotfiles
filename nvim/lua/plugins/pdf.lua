return {
    {
        "basola21/PDFview",
        lazy = false,
        dependencies = { "nvim-telescope/telescope.nvim" },
        ft = { "pdf" },
        config = function()
            vim.keymap.set(
                "n",
                "<leader>pj",
                "<cmd>:lua require('pdfview.renderer').next_page()<CR>",
                { desc = "_p_df next page" }
            )
            vim.keymap.set(
                "n",
                "<leader>pk",
                "<cmd>:lua require('pdfview.renderer').previous_page()<CR>",
                { desc = "_p_df previous page" }
            )
            vim.api.nvim_create_autocmd("BufReadPost", {
                pattern = "*.pdf",
                callback = function()
                    local file_path = vim.api.nvim_buf_get_name(0)
                    require("pdfview").open(file_path)
                end,
            })
        end,
    },
}
