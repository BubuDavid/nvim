return {
	"rmagatti/auto-session",
	lazy = false,
	dependencies = {
		"nvim-telescope/telescope.nvim", -- Only needed if you want to use session lens
	},

	config = function()
		require("auto-session").setup({
			suppressed_dirs = { "~/", "/" },
			enabled = true,
			previewer = true,
		})
		vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,resize,terminal"
	end,
}
