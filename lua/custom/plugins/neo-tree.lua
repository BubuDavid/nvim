-- Unless you are still migrating, remove the deprecated commands from v1.x
vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])
vim.keymap.set('n', '<c-b>', ':Neotree toggle float<CR>', {})
vim.keymap.set('i', '<c-b>', '<ESC>:Neotree toggle float<CR>', {})

return {
	"nvim-neo-tree/neo-tree.nvim",
	version = "*",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
		"MunifTanjim/nui.nvim",
	},
	config = function()
		require('neo-tree').setup {
			filesystem = {
				window = {
					mappings = {
						["o"] = {
							command = "open",
							nowait = true
						}
					}
				}
			}
		}
	end
}
