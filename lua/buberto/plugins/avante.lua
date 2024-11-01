return {
	"yetone/avante.nvim",
	event = "VeryLazy",
	lazy = false,
	version = false, -- set this if you want to always pull the latest change
	opts = {
		provider = "copilot",
		hints = { enable = false },
		windows = {
			wrap = true,
			width = 30,
			sidebar_header = {
				enabled = true,
				align = "center",
				rounded = true,
			},
			edit = {
				border = "rounded",
				start_insert = false, -- Start insert mode when opening the edit window
			},
		},
	},
	-- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
	build = "make",
	-- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
	dependencies = {
		"nvim-treesitter/nvim-treesitter",
		"stevearc/dressing.nvim",
		"nvim-lua/plenary.nvim",
		"MunifTanjim/nui.nvim",
		--- The below dependencies are optional,
		"nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
		"zbirenbaum/copilot.lua", -- for providers='copilot'
		{
			-- support for image pasting
			"HakonHarnes/img-clip.nvim",
			event = "VeryLazy",
			opts = {
				-- recommended settings
				default = {
					embed_image_as_base64 = false,
					prompt_for_file_name = false,
					drag_and_drop = {
						insert_mode = true,
					},
					-- required for Windows users
					use_absolute_path = true,
				},
			},
		},
		{
			-- Make sure to set this up properly if you have lazy=true
			"MeanderingProgrammer/render-markdown.nvim",
			opts = {
				enabled = true,
				file_types = { "markdown", "Avante" },
				render_modes = true,
				win_options = {
					conceallevel = { rendered = 2 },
					concealcursor = { rendered = "nc" },
				},
				anti_conceal = {
					-- Preserve glyphs in normal mode but make them "anti_conceal" in insert mode to
					-- replicate concealcursor behaviour
					ignore = {
						bullet = { "n" },
						callout = { "n" },
						check_icon = { "n" },
						check_scope = { "n" },
						code_language = { "n" },
						dash = { "n" },
						head_icon = { "n" },
						link = { "n" },
						quote = { "n" },
						table_border = { "n" },
					},
				},
			},
		},
	},
}
