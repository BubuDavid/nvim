return {
	-- My dumb way of solving the colorscheme variation with different themes!
	"rose-pine/neovim",
	dependencies = {
		"folke/tokyonight.nvim",
		"Shatur/neovim-ayu",
		{
			"catppuccin/nvim",
			name = "catppuccin",
		},
	},
	config = function()
		vim.cmd("colorscheme tokyonight-night")
	end
}
