return {
    {
        "basola21/PDFview",
        lazy = false,
        dependencies = { "nvim-telescope/telescope.nvim" },
        ft = { "pdf" },
        config = function()
            vim.api.nvim_create_autocmd("BufReadCmd", {
                pattern = "*.pdf",
                callback = function()
                    local buf = vim.api.nvim_get_current_buf()
                    local file_path = vim.api.nvim_buf_get_name(buf)
                    local text = require("pdfview.parser").extract_text(file_path)
                    if not text then
                        vim.notify("Could not extract text from PDF", vim.log.levels.ERROR)
                        return
                    end
                    vim.api.nvim_buf_set_lines(buf, 0, -1, false, vim.split(text, "\n"))
                    vim.bo[buf].buftype = "nofile"
                    vim.bo[buf].swapfile = false
                    vim.bo[buf].modifiable = false
                    vim.bo[buf].filetype = "pdfview"
                end,
            })
        end,
    },
}
