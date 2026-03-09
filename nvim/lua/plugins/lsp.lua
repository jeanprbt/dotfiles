return {
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            "L3MON4D3/LuaSnip",
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-path",
            "saadparwaiz1/cmp_luasnip",
            "onsails/lspkind.nvim",
        },
        opts = function()
            local cmp = require("cmp")
            local luasnip = require("luasnip")
            local lspkind = require("lspkind")
            return {
                snippet = {
                    expand = function(args)
                        require("luasnip").lsp_expand(args.body)
                    end,
                },
                window = {
                    completion = cmp.config.window.bordered(),
                    documentation = cmp.config.window.bordered(),
                },
                mapping = cmp.mapping.preset.insert({
                    ["<C-u>"] = cmp.mapping.scroll_docs(-4),
                    ["<C-d>"] = cmp.mapping.scroll_docs(4),
                    ["<C-e>"] = cmp.mapping.abort(),
                    ["<cr>"] = cmp.mapping.confirm({ select = true }),
                    ["<Tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_next_item()
                        elseif luasnip.expand_or_jumpable() then
                            luasnip.expand_or_jump()
                        else
                            fallback()
                        end
                    end, { "i", "s" }),
                    ["<S-Tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_prev_item()
                        elseif luasnip.jumpable(-1) then
                            luasnip.jump(-1)
                        else
                            fallback()
                        end
                    end, { "i", "s" }),
                }),
                sources = cmp.config.sources({
                    { name = "nvim_lsp", group_index = 2 },
                    { name = "luasnip", group_index = 2 },
                    { name = "path", group_index = 2 },
                    { name = "buffer" },
                    { name = "lazydev", group_index = 0 },
                }),
                formatting = {
                    format = lspkind.cmp_format(),
                },
                enabled = function()
                    local context = require("cmp.config.context")
                    if vim.api.nvim_get_mode().mode == "c" then
                        return true
                    else
                        return not context.in_treesitter_capture("comment") and not context.in_syntax_group("Comment")
                    end
                end,
            }
        end,
    },
    {
        "mason-org/mason.nvim",
        keys = {
            { "<leader>cm", "<cmd>Mason<cr>", desc = "_c_ode _m_ason" },
        },
    },
    {
        "mason-org/mason-lspconfig.nvim",
        opts = {
            ensure_installed = {
                "lua_ls",
                "jsonls",
                "yamlls",
                "taplo",
                "ty",
                "vtsls",
                "tailwindcss",
            },
        },
    },
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            { "b0o/SchemaStore.nvim", lazy = true, version = false },
        },
        opts = {
            servers = {
                ["*"] = {
                    keys = {
                        { "<c-k>", false },
                        { "gI", false },
                        { "gK", false },
                        { "gy", false },
                        { "gD", false },
                        { "<leader>cA", false },
                        { "<leader>cc", false },
                        { "<leader>cl", false },
                        { "<leader>cr", false },
                        { "<leader>cC", false },
                        { "<leader>cR", false },
                        { "<a-n>", false },
                        { "<p-n>", false },
                        {
                            "<leader>cr",
                            function()
                                local inc_rename = require("inc_rename")
                                return ":" .. inc_rename.config.cmd_name .. " " .. vim.fn.expand("<cword>")
                            end,
                            expr = true,
                            desc = "_c_ode _r_ename",
                            han = "rename",
                        },
                        { "<leader>ca", vim.lsp.buf.code_action, desc = "_c_ode _a_ction", has = "codeAction" },
                        {
                            "<leader>ci",
                            function()
                                Snacks.picker.lsp_config()
                            end,
                            desc = "_c_ode i_nfo",
                        },
                    },
                },
                jsonls = {
                    before_init = function(_, new_config)
                        new_config.settings.json.schemas = new_config.settings.json.schemas or {}
                        vim.list_extend(new_config.settings.json.schemas, require("schemastore").json.schemas())
                    end,
                    settings = {
                        json = {
                            format = {
                                enable = true,
                            },
                            validate = { enable = true },
                        },
                    },
                },
                yamlls = {
                    before_init = function(_, new_config)
                        new_config.settings.yaml.schemas = vim.tbl_deep_extend(
                            "force",
                            new_config.settings.yaml.schemas or {},
                            require("schemastore").yaml.schemas()
                        )
                    end,
                    settings = {
                        redhat = { telemetry = { enabled = false } },
                        yaml = {
                            keyOrdering = false,
                            format = {
                                enable = true,
                            },
                            validate = true,
                            schemaStore = {
                                enable = false,
                                url = "",
                            },
                        },
                    },
                },
                taplo = {
                    settings = {
                        evenBetterToml = {
                            schema = {
                                associations = {
                                    ["example\\.toml$"] = "https://json.schemastore.org/example.json",
                                },
                            },
                        },
                    },
                },
            },
        },
    },
    {
        "VonHeikemen/searchbox.nvim",
        dependencies = {
            "MunifTanjim/nui.nvim",
        },
        config = function()
            vim.keymap.set("n", "<leader>cs", function()
                require("searchbox").replace({ show_matches = "[{total}]", confirm = "menu" })
            end, { desc = "_c_ode _s_ubstitute" })
        end,
    },
}
