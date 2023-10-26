return {
	"VonHeikemen/fine-cmdline.nvim",
	dependencies = {
		"MunifTanjim/nui.nvim"
	},
	config = function()
		vim.keymap.set("n", "<leader>h", "<cmd>FineCmdline<CR>", { desc = "Open fine command line" })
	end
}
