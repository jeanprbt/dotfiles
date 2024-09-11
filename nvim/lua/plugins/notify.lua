return {
	"rcarriga/nvim-notify",
	config = function()
		local notify = require("notify")
		notify.setup({
			background_colour = "#1e222a",
			render = "wrapped-compact",
			stages = "fade",
			timeout = 4000,
		})
		vim.notify = notify
	end,
}
