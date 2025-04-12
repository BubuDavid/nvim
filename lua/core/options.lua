-- Basic opt or 'set' configs --

-- Adjust relative numbers and current line number
vim.opt.relativenumber = true
vim.opt.number = true

-- Indentation style
vim.opt.tabstop = 2       -- 2 Spaces for tabs
vim.opt.shiftwidth = 2    -- Indent width
vim.opt.autoindent = true -- Indent from same level when starting a new line

-- Keep undo file after quiting
vim.opt.undofile = true

-- Signcolumn always width 1
vim.opt.signcolumn = "yes:1"

-- Incremental search instead of just highlight after Enter
vim.opt.incsearch = true

-- Set termguicolors
vim.opt.termguicolors = true

-- Highlight current line
vim.opt.cursorline = true

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

-- Set default colorscheme
vim.cmd("colorscheme habamax")
