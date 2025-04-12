return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	config = function()
		local configs = require("nvim-treesitter.configs")

		configs.setup({
			modules = {},
			ignore_install = {},
			auto_install = true,
			ensure_installed = { "c", "lua", "javascript", "html", "python" },
			sync_install = false,
			highlight = { enable = true },
			indent = { enable = true },
		})
	end
}
