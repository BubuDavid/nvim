return {
	"saghen/blink.cmp",
	build = 'cargo build --release',
	dependencies = {
		"rafamadriz/friendly-snippets",
		"kristijanhusak/vim-dadbod-completion"
	},
	version = "1.*",

	opts = {
		keymap = {
			preset = "default",
		},
		appearance = {
			use_nvim_cmp_as_default = true,
			nerd_font_variant = "mono",
		},
		completion = {
			documentation = {
				auto_show = true,
				window = { border = "rounded" },
			},
			menu = {
				border = "rounded",
			},
		},
		sources = {
			per_filetype = { sql = { "dadbod", "lsp", "buffer" } },
			providers = {
				dadbod = {
					name = "Dadbod",
					module = "vim_dadbod_completion.blink"
				},
				path = {
					opts = {
						get_cwd = function(_)
							return vim.fn.getcwd()
						end,
					},
				},
				cmdline = {
					enabled = function()
						local prompt_type = vim.fn.getcmdtype()
						if prompt_type == ":" then
							local prompt = vim.fn.getcmdline()
							if prompt:match("^[%%0-9,'<>%-]*!") or #prompt <= 2 then
								return false
							end
						else
						end
						return true
					end
				},
			},
		},
		signature = {
			enabled = true,
			window = {
				border = "rounded",
			},
		},
		cmdline = {
			completion = {
				menu = {
					auto_show = true
				}
			}
		}
	},
}
