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

-- Set default colorscheme
vim.cmd("colorscheme habamax")

-- This is needed for obsidian.nvim
vim.opt.conceallevel = 2
vim.opt.concealcursor = ""
