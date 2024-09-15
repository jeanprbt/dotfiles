-- Indentation --
vim.cmd(":set expandtab")
vim.cmd(":set tabstop=4")
vim.cmd(":set softtabstop=4")
vim.cmd(":set shiftwidth=4")
vim.cmd(":set noshowmode")
vim.cmd(":set noshowcmd")
vim.cmd(":set shortmess+=F")

-- Numbers --
vim.cmd(":set number")
vim.cmd(":set relativenumber")

local function clear_command_line()
	vim.defer_fn(function()
		vim.cmd("echon ''")
	end, 0)
end

vim.api.nvim_create_autocmd("CmdlineLeave", {
	callback = clear_command_line,
})
