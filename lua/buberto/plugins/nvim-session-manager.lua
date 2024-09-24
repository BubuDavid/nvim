return {
	"rmagatti/auto-session",
	enabled = false,
	lazy = false,
	dependencies = {
		"nvim-telescope/telescope.nvim", -- Only needed if you want to use session lens
	},

	config = function()
		vim.keymap.set(
			{ "n", "v" },
			"<leader>ss",
			":SessionSearch<CR><ESC> ",
			{ desc = "Search for a session" }
		)
		vim.keymap.set({ "n", "v" }, "<leader>sd", ":SessionDelete<CR> ", { desc = "Search for a session" })
		require("auto-session").setup({
			suppressed_dirs = { "~/", "/" },
			enabled = true,
			session_lens = {
				load_on_setup = true, -- Initialize on startup (requires Telescope)
				previewer = true, -- File preview for session picker
			},
		})
		vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,resize,terminal"
	end,
}
