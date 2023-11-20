return {
	"akinsho/bufferline.nvim",
	version = "*",
	dependencies = "nvim-tree/nvim-web-devicons",
	config = function()
		local bufferline = require("bufferline")
		bufferline.setup({
			options = {
				mode = "buffers",
				indicator = {
					icon = "▎", -- this should be omitted if indicator style is not 'icon'
					style = "icon",
				},
				buffer_close_icon = "󰅖",
				modified_icon = "●",
				close_icon = "",
				left_trunc_marker = "",
				right_trunc_marker = "",
				diagnostics = "nvim_lsp",
				separator_style = "thin",
				style_preset = bufferline.style_preset.minimal,
				always_show_bufferline = true,
				hover = {
					enabled = true,
					delay = 200,
					reveal = { "close" },
				},
				offsets = {
					{
						filetype = "NvimTree",
						text = "File Explorer",
						highlight = "Directory",
						separator = false, -- use a "true" to enable the default, or set your own character
					},
				},
			},
		})
	end,
}
