return {
    {
        "linux-cultist/venv-selector.nvim",
        cmd = "VenvSelect",
        opts = {
            options = {
                notify_user_on_venv_activation = true,
                override_notify = false,
            },
        },
        ft = "python",
        keys = { { "<leader>cv", "<cmd>:VenvSelect<cr>", desc = "_c_hoose _v_irtualenv", ft = "python" } },
    },
}
