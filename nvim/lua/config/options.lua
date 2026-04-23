-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- set leader key to comma
vim.g.mapleader = ","

-- set default indentation to 4
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.expandtab = tru

-- remove write notification
vim.opt.shortmess = "FOItCTcol"

-- remove auto-copy to clipboard
vim.opt.clipboard = ""

-- disable concealing
vim.opt.conceallevel = 0

-- enable line wrapping
vim.opt.wrap = true

-- python virtualenv
vim.g.python3_host_prog = vim.fn.expand("~/.virtualenvs/neovim/bin/python3")
