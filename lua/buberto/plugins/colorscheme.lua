function ColorMyPencils(color)
	color = color or "rose-pine-moon"
	vim.cmd.colorscheme(color)

	vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
	vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end

return {
	{
		"rose-pine/neovim",
		config = function()
			-- ColorMyPencils("rose-pine-moon")
		end,
	},

	{
		"folke/tokyonight.nvim",
		config = function()
			ColorMyPencils("tokyonight")
		end,
	},
}
