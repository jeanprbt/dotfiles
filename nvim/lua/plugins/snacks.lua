return {
    {
        "folke/snacks.nvim",
        keys = {
            { "<leader><space>", false },
            { "<leader>:", false },
            { "<leader>n", false },
            { "<leader>fB", false },
            { "<leader>fF", false },
            { "<leader>fg", false },
            { "<leader>fp", false },
            { "<leader>fr", false },
            { "<leader>fR", false },
            { "<leader>gS", false },
            { "<leader>gI", false },
            { "<leader>gP", false },
            { '<leader>s"', false },
            { "<leader>s/", false },
            { "<leader>sR", false },
            { "<leader>sa", false },
            { "<leader>sb", false },
            { "<leader>sB", false },
            { "<leader>sG", false },
            { "<leader>sp", false },
            { "<leader>sq", false },
            { "<leader>sc", false },
            { "<leader>sg", false },
            { "<leader>sC", false },
            { "<leader>sh", false },
            { "<leader>sH", false },
            { "<leader>sj", false },
            { "<leader>sk", false },
            { "<leader>sM", false },
            { "<leader>su", false },
            { "<leader>sw", false },
            { "<leader>sW", false },
            {
                "<leader>fc",
                function()
                    Snacks.picker.command_history()
                end,
                desc = "_f_ind _c_ommands",
            },
            {
                "<leader>fb",
                function()
                    Snacks.picker.buffers()
                end,
                desc = "_f_ind _b_uffers",
            },
            {
                "<leader>fn",
                function()
                    Snacks.picker.notifications()
                end,
                desc = "_f_ind _n_otifications",
            },
            {
                "<leader>ff",
                function()
                    Snacks.picker.files({ cwd = vim.fn.getcwd() })
                end,
                desc = "_f_ind _f_iles",
            },
            {
                "<leader>gd",
                function()
                    Snacks.picker.git_diff()
                end,
                desc = "_g_it _d_iff",
            },
            {
                "<leader>gD",
                function()
                    Snacks.picker.git_diff({ base = "origin", group = true })
                end,
                desc = "_g_it _D_iff with origin",
            },
            {
                "<leader>gs",
                function()
                    Snacks.picker.git_status()
                end,
                desc = "_g_it _s_tatus",
            },
            {
                "<leader>gi",
                function()
                    Snacks.picker.gh_issue()
                end,
                desc = "_g_ithub _i_ssues",
            },
            {
                "<leader>gp",
                function()
                    Snacks.picker.gh_pr()
                end,
                desc = "_g_ithub _p_ull requests",
            },
            {
                "<leader>sl",
                function()
                    Snacks.picker.lines()
                end,
                desc = "_s_earch _l_ines",
            },
            { "<leader>,", LazyVim.pick("live_grep"), desc = "search globally" },
            {
                "<leader>si",
                function()
                    Snacks.picker.icons()
                end,
                desc = "_s_earch _i_cons",
            },
            {
                "<leader>sd",
                function()
                    Snacks.picker.diagnostics()
                end,
                desc = "_s_earch _d_iagnostics",
            },
            {
                "<leader>sD",
                function()
                    Snacks.picker.diagnostics_buffer()
                end,
                desc = "_s_earch buffer _D_iagnostics",
            },
            {
                "<leader>sm",
                function()
                    Snacks.picker.man()
                end,
                desc = "_s_earch _m_an pages",
            },
            {
                "<leader>sr",
                function()
                    Snacks.picker.lsp_references()
                end,
                desc = "_s_earch _r_eferences",
            },
            {
                "<leader>ss",
                function()
                    Snacks.picker.lsp_symbols()
                end,
                desc = "_s_earch _s_ymbols",
            },
            {
                "<leader>sS",
                function()
                    Snacks.picker.lsp_workspace_symbols()
                end,
                desc = "_s_earch workspace _S_ymbols",
            },
        },
        opts = function(_, opts)
            opts.dashboard.preset.header = [[
         ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
         ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║
         ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║
         ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║
         ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
         ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝]]
            opts.dashboard.preset.keys = {
                {
                    icon = " ",
                    key = "a",
                    desc = "Open Folder",
                    action = ":Neotree",
                },
                { icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
                { icon = " ", key = "g", desc = "Find Text", action = ":lua Snacks.dashboard.pick('live_grep')" },
                {
                    icon = " ",
                    key = "c",
                    desc = "Config",
                    action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})",
                },
                { icon = "󰒲 ", key = "l", desc = "Lazy", action = ":Lazy" },
                { icon = "󰊳 ", key = "m", desc = "LSP", action = ":Mason" },
                { icon = " ", key = "q", desc = "Quit", action = ":qa" },
            }
        end,
    },
}
