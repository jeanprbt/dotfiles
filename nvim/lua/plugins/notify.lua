return {
	"rcarriga/nvim-notify",
	opts = {
		background_colour = "#1e222a",
		render = "wrapped-compact",
		stages = "fade",
		timeout = 2000,
	},
	config = function(_, opts)
		local notify = require("notify")
		notify.setup(opts)
		vim.notify = notify
	end,
}
