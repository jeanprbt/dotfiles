-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vvim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")
vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

-- External file refresh: detect and reload files modified by AI CLI tools
-- (claude-code, mistral-vibe, etc.) or any other external process.
-- LazyVim already handles FocusGained/TermClose/TermLeave; this extends
-- coverage with additional events and a periodic timer.
do
    local augroup = vim.api.nvim_create_augroup("external_file_refresh", { clear = true })

    vim.api.nvim_create_autocmd({
        "CursorHold",
        "CursorHoldI",
        "BufEnter",
        "BufWinEnter",
        "InsertLeave",
        "TermEnter",
    }, {
        group = augroup,
        pattern = "*",
        callback = function()
            if vim.fn.filereadable(vim.fn.expand("%")) == 1 then
                vim.cmd("checktime")
            end
        end,
        desc = "Check for external file changes on disk",
    })

    -- Periodic timer: poll for changes every 1s even without user interaction
    local timer = vim.uv.new_timer()
    if timer then
        timer:start(
            1000,
            1000,
            vim.schedule_wrap(function()
                if vim.api.nvim_get_mode().mode ~= "c" then
                    vim.cmd("silent! checktime")
                end
            end)
        )
    end

    -- Notification on external file change
    vim.api.nvim_create_autocmd("FileChangedShellPost", {
        group = augroup,
        pattern = "*",
        callback = function()
            vim.notify("Buffer reloaded (file changed on disk)", vim.log.levels.INFO)
        end,
        desc = "Notify on external file change",
    })
end
