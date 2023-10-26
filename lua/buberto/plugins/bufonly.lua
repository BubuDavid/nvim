return {
	"numtostr/BufOnly.nvim",
  event = { "BufReadPre", "BufNewFile" },
	config = function()
		vim.keymap.set("n", "<leader>x", ":BufOnly<CR>i<ESC>", { noremap = true, silent = true })
	end
}
