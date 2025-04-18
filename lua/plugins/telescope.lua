return {
	'nvim-telescope/telescope.nvim',
	branch = '0.1.x',
	dependencies = {
		'nvim-lua/plenary.nvim',
		{
			'nvim-telescope/telescope-fzf-native.nvim',
			build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release'
		}
	},
	config = function()
		local actions = require("telescope.actions")
		-- Simple FZF load
		require("telescope").setup({
			defaults = {
				vimgrep_arguments = {
					'rg',
					'--color=never',
					'--no-heading',
					'--with-filename',
					'--line-number',
					'--column',
					'--smart-case',
					'--no-ignore', -- No ignore the .gitignores
				},
				file_ignore_patterns = {
					-- Generals
					".git/",
					-- JavaScript & TypeScript
					"node_modules/",
					".next/",
					-- Python
					"**venv/",
					"__pycache__",
					".pytest_cache",
				},
				mappings = {
					i = {
						["<C-y>"] = actions.select_default
					}
				},
			},
			extensions = {
				fzf = {}
			}
		})
		require("telescope").load_extension("fzf")

		local builtin = require("telescope.builtin")
		local ivy_theme = require("telescope.themes").get_ivy(
			{ no_ignore = true, no_ignore_parent = true, hidden = true }
		)

		vim.keymap.set("n", "<leader>ff", function()
			builtin.find_files(ivy_theme)
		end, { desc = "Open Fuzzy Finder with Telescope" })

		vim.keymap.set("n", "<leader>fo", function()
			builtin.oldfiles(ivy_theme)
		end, { desc = "FF Old Files" })

		vim.keymap.set("n", "<leader>fs", function()
			builtin.live_grep(ivy_theme)
		end, { desc = "FF Grep String in current project" })

		vim.keymap.set("n", "<leader>fk", function()
			builtin.keymaps(ivy_theme)
		end, { desc = "Telescope keymaps" })

		vim.keymap.set("n", "<leader>fp", function()
			local cwd = vim.fn.getcwd() .. "/"
			local possible_env_dirs = { ".venv/", "venv/" }
			local env_dir = nil
			for _, dir in ipairs(possible_env_dirs) do
				local path = cwd .. dir
				if vim.fn.isdirectory(path) == 1 then
					env_dir = path
					break
				end
			end
			if env_dir == nil then
				print("Not possible to find virtual environment")
			else
				local complete_path = env_dir .. "lib/"
				builtin.live_grep({
					cwd = complete_path
				})
			end
		end, { desc = "Telescope Live Grep String over Python libraries" })

		vim.keymap.set({"n", "v"}, "<leader>fr", function()
			builtin.registers(ivy_theme)
		end, { desc = "Telescope Registers" })

		vim.keymap.set("n", "<leader>fb", function()
			builtin.buffers(ivy_theme)
		end, { desc = "Telescope Buffers" })

		vim.keymap.set("n", "<leader>fj", function()
			builtin.jumplist(ivy_theme)
		end, { desc = "Telescope Jump List" })

		vim.keymap.set("n", "<leader>fc", function()
			builtin.colorscheme(ivy_theme)
		end, { desc = "Telescope Jump List" })

		vim.keymap.set("n", "<leader>fh", function()
			builtin.help_tags(ivy_theme)
		end, { desc = "Telescope help tags" })

		vim.keymap.set("n", "<leader>ft", function()
			builtin.builtin(ivy_theme)
		end, { desc = "Open Telescope to search what stuff there are actually on Telescope" })
	end
}
