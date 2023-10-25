local opt = vim.opt
local o = vim.o

-- Line Numbers
opt.relativenumber = true
opt.number = true

-- Indentation
opt.tabstop = 2 -- 2 Spaces for tabs (prettier default)
opt.shiftwidth = 2 -- 2 Spaces for indent width
opt.autoindent = true -- Copy indent from current line when starting a new one

-- Bye bye highlight on search
opt.hlsearch = false

-- Save undo history
opt.undofile = true

-- Differentiate between upper case and lower case in search
opt.ignorecase = false

-- Decrease update time
opt.updatetime = 250
opt.timeoutlen = 300

-- To have better completion experience
opt.completeopt = "menuone,noselect"

-- Termiguicolors
opt.termguicolors = true

-- Highlight the current line
opt.cursorline = true

-- Cursor always in block
o.guicursor = true

-- Highlight on yank
vim.highlight.on_yank()

