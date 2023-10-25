return {
	"nvim-telescope/telescope.nvim", 
	branch = "0.1.x",
	dependencies = { 
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons",
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
	},
	config = function()
		local telescope = require("telescope")
		local actions = require("telescope.actions")
		
		telescope.setup({
			defaults = {
				path_display = { "truncate " },
				mappings = {
					i = {
						["<C-k>"] = actions.move_selection_previous, -- move to prev result
						["<C-j>"] = actions.move_selection_next, -- move to next result
						["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
					},
				},
			},
		})

		telescope.load_extension("fzf")

		vim.keymap.set("n", "<C-p>", "<cmd>Telescope git_files<CR>", { desc = "Fuzzy Find files in git (ignore node modules for example" })
		vim.keymap.set("n", "<leader>sf", "<cmd>Telescope find_files<CR>", { desc = "Fuzzy Find files in cwd" })
		vim.keymap.set("n", "<leader>of", "<cmd>Telescope oldfiles<CR>", { desc = "Fuzzy Find recent files" })
		vim.keymap.set("n", "<leader>sg", "<cmd>Telescope live_grep<CR>", { desc = "Find string in cwd" })
		vim.keymap.set("n", "<leader>usg", "<cmd>Telescope grep_string<CR>", { desc = "Find string under cursor in cwd" })
		
	end
}
