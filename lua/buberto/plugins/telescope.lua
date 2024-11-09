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
				file_ignore_patterns = {
					".git",
					"node_modules",
					"venv",
					"__pycache__",
					".pytest_cache",
				},
				mappings = {
					i = {
						["<C-k>"] = actions.move_selection_previous, -- move to prev result
						["<C-j>"] = actions.move_selection_next, -- move to next result
						["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
					},
				},
				layout_config = {
					prompt_position = "bottom",
					horizontal = {
						mirror = false,
						preview_cutoff = 100,
						preview_width = 0.5,
					},
					vertical = {
						mirror = true,
						preview_cutoff = 0.4,
					},
					flex = {
						flip_columns = 128,
					},
					height = 0.94,
					width = 0.86,
				},
			},
		})

		telescope.load_extension("fzf")

		vim.keymap.set(
			"n",
			"<C-p>",
			"<cmd>Telescope git_files<CR>",
			{ desc = "Fuzzy Find files in git (ignore node modules for example" }
		)
		vim.keymap.set(
			"n",
			"<leader>ff",
			"<cmd>lua require'telescope.builtin'.find_files({ find_command = {'rg', '--files', '--hidden', '-u'}})<cr>"
		)
		vim.keymap.set("n", "<leader>fo", "<cmd>Telescope oldfiles<CR>", { desc = "Fuzzy Find recent files" })
		vim.keymap.set("n", "<leader>fk", "<cmd>Telescope keymaps<CR>", { desc = "Find Keymaps" })
		vim.keymap.set("n", "<leader>fg", "<cmd>Telescope live_grep<CR>", { desc = "Find string in cwd" })
		vim.keymap.set(
			"n",
			"<leader>fu",
			"<cmd>Telescope grep_string<CR>",
			{ desc = "Find string under cursor in cwd" }
		)
		vim.keymap.set("n", "<leader>fr", "<cmd>Telescope registers<CR>", { desc = "Search Registers" })
		vim.keymap.set(
			"n",
			"<leader>f/",
			"<cmd>Telescope current_buffer_fuzzy_find<CR>",
			{ desc = "Search Registers" }
		)

		vim.keymap.set("n", "<leader>gc", "<cmd>Telescope git_commits<CR>", { desc = "Search Git Commits" })
		vim.keymap.set("n", "<leader>fj", "<cmd>Telescope jumplist<CR>", { desc = "Fuzzy Find jumplist" })
		vim.keymap.set("n", "<leader>gs", "<cmd>lua require'telescope.builtin'.git_status()<CR>", {
			desc = "Fuzzy Find git status",
		})
		vim.keymap.set(
			"n",
			"<leader>fh",
			"<cmd>lua require'telescope.builtin'.live_grep({ cwd = 'venv/lib/python3.12/site-packages' })<cr>",
			{
				desc = "Grep inside venv/",
			}
		)
	end,
}
