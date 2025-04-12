return {
	'stevearc/oil.nvim',
	dependencies = { { "echasnovski/mini.icons", opts = {} } },
	config = function()
		require("oil").setup({
			columns = {
				"icon",
				"birthtime",
				"size",
			},
			win_options = {
				signcolumn = "yes:1",
			},
			delete_to_trash = true,
			keymaps = {
				["<C-p>"] = { "actions.preview", opts = { split = "botright" } },
				["<BS>"] = { "actions.parent", mode = "n" },
			}
		})
		-- OIL
		vim.keymap.set("n", "<leader>nt", ":Oil<CR>", { desc = "Open Oil" })
	end
}
