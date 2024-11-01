return {
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
			-- Preserve glyphs in normal mode but make them "anti_conceal"
			-- in insert mode to replicate concealcursor behaviour
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
}
