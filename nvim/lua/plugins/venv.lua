return {
    {
        "linux-cultist/venv-selector.nvim",
        cmd = "VenvSelect",
        ft = "python",
        keys = { { "<leader>cv", "<cmd>:VenvSelect<cr>", desc = "_c_hoose _v_irtualenv", ft = "python" } },
        config = function(_, opts)
            local vs = require("venv-selector")
            vs.setup(opts)
            local function find_venv(start_path)
                local path = start_path
                while path ~= "" and path ~= "/" do
                    local venv_path = path .. "/.venv"
                    if vim.fn.isdirectory(venv_path) == 1 then
                        return venv_path .. "/bin/python"
                    end
                    path = vim.fn.fnamemodify(path, ":h")
                end
                return nil
            end

            local python_path = find_venv(vim.fn.getcwd())
            if python_path and vim.fn.executable(python_path) == 1 then
                vs.activate_from_path(python_path, "venv")
                local venv_dir = python_path:gsub("/bin/python", "")
                local short_path = vim.fn.fnamemodify(venv_dir, ":~")
                vim.notify("Auto-activated: **" .. short_path .. "**", vim.log.levels.INFO, {
                    title = "venv-selector",
                })
            end
        end,
    },
}
