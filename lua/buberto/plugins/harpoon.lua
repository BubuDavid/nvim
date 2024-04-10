return {
	"ThePrimeagen/harpoon",
	dependecies = {
		"nvim-lua/plenary.nvim",
	},
	branch = "harpoon2",
	config = function()
		local harpoon = require("harpoon")
		-- REQUIRED
		harpoon:setup({
			settings = {
				save_on_toggle = true,
				sync_on_ui_close = true,
			},
		})
		-- REQUIRED

		-- basic telescope configuration
		-- local conf = require("telescope.config").values
		-- local function toggle_telescope(harpoon_files)
		-- 	local file_paths = {}
		-- 	for _, item in ipairs(harpoon_files.items) do
		-- 		table.insert(file_paths, item.value)
		-- 	end
		--
		-- 	require("telescope.pickers").new({}, {
		-- 		prompt_title = "Harpoon",
		-- 		finder = require("telescope.finders").new_table({
		-- 			results = file_paths,
		-- 		}),
		-- 		previewer = conf.file_previewer({}),
		-- 		sorter = conf.generic_sorter({}),
		-- 	}):find()
		-- end

		-- vim.keymap.set("n", "<leader>h", function()
		-- 	toggle_telescope(harpoon:list())
		-- end, { desc = "Toggle Harpoon menu" })

		-- Regular without telescope
		vim.keymap.set("n", "<leader>h", function()
			harpoon.ui:toggle_quick_menu(harpoon:list())
		end, { desc = "Mark the current file" })

		vim.keymap.set("n", "<leader>ma", function()
			harpoon:list():append()
			print("Mark Added 🔥")
		end, { desc = "Add a mark in that file" })

		vim.keymap.set("n", "<leader>md", function()
			harpoon:list():remove()
			print("Mark Removed 🗑")
		end)

		vim.keymap.set("n", "<leader>1", function()
			harpoon:list():select(1)
		end, { desc = "Go to mark 1" })

		vim.keymap.set("n", "<leader>2", function()
			harpoon:list():select(2)
		end, { desc = "Go to mark 2" })

		vim.keymap.set("n", "<leader>3", function()
			harpoon:list():select(3)
		end, { desc = "Go to mark 3" })

		vim.keymap.set("n", "<leader>4", function()
			harpoon:list():select(4)
		end, { desc = "Go to mark 4" })
	end,
}
