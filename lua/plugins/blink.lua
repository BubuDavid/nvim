return {
	"saghen/blink.cmp",
	build = 'cargo build --release', -- for delimiters
	dependencies = { "rafamadriz/friendly-snippets" },
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
			providers = {
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
