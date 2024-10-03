return {
	dir = "~/vid/create-lua-plugins/HelperFiles.nvim",
	name = "helperfiles",
	config = function()
		require("helperfiles").setup()
	end,
}
