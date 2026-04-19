require("quarto").activate()

-- Pull diagnostics from otter buffer LSP servers.
-- Neovim's built-in pull diagnostic mechanism skips hidden buffers
-- (only_visible=true), so otter buffers never get diagnostics.
-- We manually request them after each raft sync.
do
    local main_nr = vim.api.nvim_get_current_buf()
    local function refresh_otter_diagnostics()
        local ok, keeper = pcall(require, "otter.keeper")
        if not ok then return end
        local raft = keeper.rafts[main_nr]
        if not raft then return end
        for _, otter_nr in pairs(raft.buffers) do
            local clients = vim.lsp.get_clients({
                bufnr = otter_nr,
                method = "textDocument/diagnostic",
            })
            for _, client in ipairs(clients) do
                client:request("textDocument/diagnostic", {
                    textDocument = vim.lsp.util.make_text_document_params(otter_nr),
                }, nil, otter_nr)
            end
        end
    end

    vim.api.nvim_create_autocmd({ "BufWritePost", "InsertLeave", "TextChanged" }, {
        buffer = main_nr,
        desc = "Pull diagnostics for otter buffers",
        callback = function()
            vim.defer_fn(refresh_otter_diagnostics, 200)
        end,
    })
end
