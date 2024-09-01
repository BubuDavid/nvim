return {
	"github/copilot.vim",
	config = function()
		vim.keymap.set("i", "<C-j>", 'copilot#Accept("\\<CR>")', {
			expr = true,
			replace_keycodes = false,
		})
		vim.keymap.set("n", "<leader>cd", ":Copilot disable <CR>", {})
	end,
}
