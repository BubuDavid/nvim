return {
	"rcarriga/nvim-notify",
	config = function()
		require('notify').setup({
			timeout = 2000,
			merge_duplicates = true,
			stages = 'slide',
			render = 'minimal',
			minimum_width = 15,
			max_width = 30,
			top_down = false,
		})
	end
}
