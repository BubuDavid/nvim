function ColorMyPencils(color)
	color = color or "rose-pine"
	vim.cmd([[colorscheme ]] .. color)

	-- vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
	-- vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end

return {
	{
		"rose-pine/neovim",
		lazy = false,
		priority = 1000,
		config = function()
			ColorMyPencils("rose-pine-moon")
		end,
	},

	{
		"folke/tokyonight.nvim",
		lazy = false,
		config = function()
			-- ColorMyPencils("tokyonight")
		end,
	},
	{
		"catppuccin/nvim",
		name = "catppuccin",
		lazy = false,
		priority = 1000,
		config = function()
			-- ColorMyPencils("catppuccin-macchiato")
		end,
	},
}
