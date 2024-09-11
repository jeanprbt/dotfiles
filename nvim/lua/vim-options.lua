-- Indentation --
vim.cmd(":set expandtab")
vim.cmd(":set tabstop=4")
vim.cmd(":set softtabstop=4")
vim.cmd(":set shiftwidth=4")

-- Numbers --
vim.cmd(":set number")
vim.cmd(":set relativenumber")

-- Command bar --
vim.opt.cmdheight = 0
vim.api.nvim_create_autocmd({ "RecordingEnter" }, {
	callback = function()
		vim.opt.cmdheight = 1
	end,
})
vim.api.nvim_create_autocmd({ "RecordingLeave" }, {
	callback = function()
		vim.opt.cmdheight = 0
	end,
})
