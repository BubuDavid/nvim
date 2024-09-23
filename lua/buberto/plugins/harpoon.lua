return {
	"ThePrimeagen/harpoon",
	dependencies = {
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

		for i = 1, 9 do
			vim.keymap.set("n", "<leader>" .. i, function()
				harpoon:list():select(i)
			end, { desc = "Go to mark " .. i })
		end

		-- Toggle previous & next buffers stored within Harpoon list
		vim.keymap.set("n", "<S-tab>", function()
			harpoon:list():prev()
		end)
		vim.keymap.set("n", "<tab>", function()
			harpoon:list():next()
		end)
	end,
}
