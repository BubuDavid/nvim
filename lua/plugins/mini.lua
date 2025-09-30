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
		-- Make quotes only pair when there's whitespace or specific characters before
		local double_quote_opts = {
			action = 'closeopen',
			pair = '""',
			neigh_pattern = '[^%a\\][^%a\\]', -- Don't pair in the middle of words
			register = { cr = false },
		}
		MiniPairs.map('i', '"', double_quote_opts)

		local quote_opts = {
			action = 'closeopen',
			pair = "''",
			neigh_pattern = '[^%a\\][^%a\\]',
			register = { cr = false },
		}
		MiniPairs.map('i', "'", quote_opts)
		local special_quotes = {
			action = 'closeopen',
			pair = '``',
			neigh_pattern = '[^%a\\][^%a\\]',
			register = { cr = false },
		}
		MiniPairs.map('i', '`', special_quotes)

		local lt_opts = {
			action = 'open',
			pair = '<>',
			neigh_pattern = '[^\\].',
			register = { cr = false },
		}
		MiniPairs.map('i', '<', lt_opts)

		local gt_opts = { action = 'close', pair = '<>', register = { cr = false } }
		MiniPairs.map('i', '>', gt_opts)

		-- Python-specific double quote handling for docstrings
		vim.api.nvim_create_autocmd('FileType', {
			pattern = 'python',
			callback = function()
				local function smart_double_quote()
					local line = vim.api.nvim_get_current_line()
					local col = vim.fn.col('.') - 1

					-- Check if there are already two consecutive quotes before cursor
					local before = line:sub(math.max(1, col - 1), col)
					if before == '""' then
						-- Just insert a single quote (for docstrings)
						return '"'
					end

					-- Check if next char is a quote (closing)
					local next_char = line:sub(col + 1, col + 1)
					if next_char == '"' then
						return '<Right>'
					end

					-- Otherwise insert pair (open and close, then move left)
					return '""<Left>'
				end
				vim.keymap.set('i', '"', smart_double_quote, { expr = true, buffer = true })
			end,
		})

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
