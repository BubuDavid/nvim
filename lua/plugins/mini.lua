return {
	"echasnovski/mini.nvim",
	version = "*",
	config = function()
		-- Indentation bars
		require("mini.indentscope").setup({
			mappings = {
				goto_top = "gs",
				goto_bottom = "gb",
			}
		})

		-- Notification system (TODO: Actually Create functionality with this)
		-- require("mini.notify").setup()

		-- TODO: Improve the signs because these are horrible
		-- Diff with git IG
		require('mini.diff').setup({
			view = {
				style = "sign"
			}
		})

		-- Surround
		-- require('mini.surround').setup()

		-- AutoPairs
		require('mini.pairs').setup({})

		local lt_opts = {
			action = 'open',
			pair = '<>',
			neigh_pattern = '[^\\].',
			register = { cr = false },
		}
		MiniPairs.map('i', '<', lt_opts)

		local gt_opts = { action = 'close', pair = '<>', register = { cr = false } }
		MiniPairs.map('i', '>', gt_opts)

		-- Starter Screen
		require("mini.starter").setup()
		-- Trailing Space
		require("mini.trailspace").setup()
		-- Status Line
		local statusline = require("mini.statusline")
		statusline.setup({
			content = {
				active = function()
					local mode, mode_hl = MiniStatusline.section_mode({ trunc_width = 120 })
					local git           = MiniStatusline.section_git({ trunc_width = 40 })
					local diff          = MiniStatusline.section_diff({ trunc_width = 75 })
					local diagnostics   = MiniStatusline.section_diagnostics({
						trunc_width = 75,
						signs = {
							ERROR = " ", WARN = " ", INFO = " ", HINT = "󰠠 "
						}
					})
					local lsp           = MiniStatusline.section_lsp({ trunc_width = 75 })
					local filename      = MiniStatusline.section_filename({ trunc_width = 140 })
					local fileinfo      = MiniStatusline.section_fileinfo({ trunc_width = 120 })
					local location      = MiniStatusline.section_location({ trunc_width = 75 })
					local search        = MiniStatusline.section_searchcount({ trunc_width = 75 })

					return MiniStatusline.combine_groups({
						{ hl = mode_hl,                 strings = { mode } },
						{ hl = "MiniStatuslineDevinfo", strings = { git, diff, diagnostics, lsp } },
						"%<", -- Mark general truncate point
						{ hl = "MiniStatuslineFilename", strings = { filename } },
						"%=", -- End left alignment
						{ hl = "MiniStatuslineFileinfo", strings = { fileinfo } },
						{ hl = mode_hl,                  strings = { search, location } },
					})
				end
			}
		})

		-- TODO: Configure this one
		local miniclue = require("mini.clue")
		miniclue.setup({
			window = {
				delay = 100,
				config = {
					width = "auto",
					border = "rounded",
				},
			},
			triggers = {
				-- Leader triggers
				{ mode = "n", keys = "<Leader>" },
				{ mode = "x", keys = "<Leader>" },

				-- Built-in completion
				{ mode = "i", keys = "<C-x>" },

				-- `g` key
				{ mode = "n", keys = "g" },
				{ mode = "x", keys = "g" },

				-- Marks
				{ mode = "n", keys = "'" },
				{ mode = "n", keys = "`" },
				{ mode = "x", keys = "'" },
				{ mode = "x", keys = "`" },

				-- Registers
				{ mode = "n", keys = "'" },
				{ mode = "x", keys = "'" },
				{ mode = "i", keys = "<C-r>" },
				{ mode = "c", keys = "<C-r>" },

				-- Window commands
				{ mode = "n", keys = "<C-w>" },

				-- `z` key
				{ mode = "n", keys = "z" },
				{ mode = "x", keys = "z" },
			},

			clues = {
				-- Enhance this by adding descriptions for <Leader> mapping groups
				miniclue.gen_clues.builtin_completion(),
				miniclue.gen_clues.g(),
				miniclue.gen_clues.marks(),
				miniclue.gen_clues.registers(),
				miniclue.gen_clues.windows(),
				miniclue.gen_clues.z(),
			},
		})
	end
}
