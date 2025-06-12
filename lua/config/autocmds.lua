-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.hl.on_yank({ timeout = 150 })
	end,
	group = vim.api.nvim_create_augroup("YankHighlight", { clear = true }),
})

-- Set a color column when in Python to have 79 lines PEP-8
vim.api.nvim_create_autocmd("FileType", {
	callback = function()
		vim.opt.colorcolumn = "80"
	end,
	group = vim.api.nvim_create_augroup("ColorColumnPythonPEP", { clear = true }),
	pattern = { "python" }
})

-- Set a color column when in Python to have 79 lines PEP-8
vim.api.nvim_create_autocmd("FileType", {
	callback = function()
		vim.cmd("set filetype=json")
	end,
	group = vim.api.nvim_create_augroup("SetJsonFiletypeWithJsonl", { clear = true }),
	pattern = { "jsonl" }
})
