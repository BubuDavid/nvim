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
			view_options = {
				is_hidden_file = function(name, _)
					local m = name:match("^%.") or name:match("^__pycache__$") or name:match("^%.pyc$")
					return m ~= nil
				end,
			},
			delete_to_trash = true,
			keymaps = {
				["<C-p>"] = { "actions.preview", opts = { split = "botright" } },
				["<BS>"] = { "actions.parent", mode = "n" },
			}
		})
		-- OIL
		vim.keymap.set("n", "<leader>nt", ":Oil<CR>", { desc = "Open Oil" })
		vim.api.nvim_create_autocmd("FileType", {
			pattern = "oil",
			group = vim.api.nvim_create_augroup("OilExit", { clear = true }),
			callback = function()
				vim.keymap.set("n", "<leader>nt", ":bd<CR>", { desc = "Close Oil with the same keymap", buffer = true })
			end
		})
	end
}
