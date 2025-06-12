-- Set leader to comma --
vim.g.mapleader = ","

-- Disable nvim's original file explorer --
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Enable line numbers --
vim.opt.number = true

-- Enable 24-bit color --
vim.opt.termguicolors = true

-- Set split navigation keymaps --
vim.keymap.set({ "n", "t" }, "<C-h>", [[<Cmd>wincmd h<cr>]], { desc = "Move to left window" })
vim.keymap.set({ "n", "t" }, "<C-j>", [[<Cmd>wincmd j<cr>]], { desc = "Move to below window" })
vim.keymap.set({ "n", "t" }, "<C-k>", [[<Cmd>wincmd k<cr>]], { desc = "Move to above window" })
vim.keymap.set({ "n", "t" }, "<C-l>", [[<Cmd>wincmd l<cr>]], { desc = "Move to right window" })

-- Package manager --
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath)

-- Plugins --
require("lazy").setup("plugins")

-- Vim options configuration --
require("vim-options")
