return {
	"ThePrimeagen/harpoon",
	branch = "harpoon2",
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		local harpoon = require('harpoon')
		harpoon:setup({})

		local harpoon_extensions = require("harpoon.extensions")
		harpoon:extend(harpoon_extensions.builtins.highlight_current_file())

		vim.keymap.set("n", "<leader>hh", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end,
			{ desc = "Open harpoon window" })
		vim.keymap.set("n", "<leader>ha", function()
				print("Harpoon mark added 🔥")
				harpoon:list():add()
			end,
			{ desc = "Add current cursor position to harpoon" })
		for i = 1, 4 do
			vim.keymap.set("n", "<leader>" .. i, function() harpoon:list():select(i) end,
				{ desc = "Go to harpoon element " .. i })
		end
	end
}
