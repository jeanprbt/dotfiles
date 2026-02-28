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
    {
        "iamcco/markdown-preview.nvim",
        cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
        build = "cd app && npm install",
        ft = { "markdown" },
        config = function()
            vim.g.mkdp_filetypes = { "markdown" }
            vim.cmd([[do FileType]])
            vim.cmd([[
                function OpenMarkdownPreview (url)
                    let cmd = "kitten @ goto-layout splits & kitten @ launch --location vsplit --keep-focus /bin/zsh -lc \"awrit " . shellescape(a:url) . "\""
                    silent call system(cmd)
                endfunction
            ]])
            vim.g.mkdp_browserfunc = "OpenMarkdownPreview"
            vim.keymap.set(
                "n",
                "<leader>mp",
                "<cmd>MarkdownPreviewToggle<cr>",
                { desc = "toggle _m_arkdown _p_review in browser" }
            )
            local function load_then_exec(cmd)
                return function()
                    vim.cmd.delcommand(cmd)
                    require("lazy").load({ plugins = { "markdown-preview.nvim" } })
                    vim.api.nvim_exec_autocmds("BufEnter", {})
                    vim.cmd(cmd)
                end
            end

            for _, cmd in pairs({ "MarkdownPreviewToggle" }) do
                vim.api.nvim_create_user_command(cmd, load_then_exec(cmd), {})
            end
        end,
    },
}
