return {
	"mbbill/undotree",
	config = function()
		vim.keymap.set("n", "<leader>ut", ":UndotreeToggle<CR>", { desc = "Toggle the Undo Tree" })
		vim.g.undotree_WindowLayout = 1
		vim.g.undotree_SetFocusWhenToggle = 1
	end,
}
