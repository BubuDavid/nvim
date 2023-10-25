return {
	"ThePrimeagen/harpoon",
	dependecies = {
		"nvim-lua/plenary.nvim"
	},
	config = function()
		local mark = require("harpoon.mark")
		local ui = require("harpoon.ui")
		
		vim.keymap.set("n", "<leader>ma", function() 
			require("harpoon.mark").add_file()
			print("Mark added 🔥")
		end, { desc = "Add a mark in that file" })
		vim.keymap.set("n", "<leader>h", ui.toggle_quick_menu, { desc = "Open the Harpoon menu" })

		vim.keymap.set("n", "<leader>1", function() ui.nav_file(1) end, { desc = "Navigate to file 1 in Harpoon" })
		vim.keymap.set("n", "<leader>2", function() ui.nav_file(2) end, { desc = "Navigate to file 2 in Harpoon" })
		vim.keymap.set("n", "<leader>3", function() ui.nav_file(3) end, { desc = "Navigate to file 3 in Harpoon" })
		vim.keymap.set("n", "<leader>4", function() ui.nav_file(4) end, { desc = "Navigate to file 4 in Harpoon" })

	end
}
