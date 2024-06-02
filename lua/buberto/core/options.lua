local opt = vim.opt
local o = vim.o

-- Add commentary options
vim.g.skip_ts_context_commentstring_module = true

-- Line Numbers
opt.relativenumber = true
opt.number = true

-- Indentation
opt.tabstop = 2 -- 2 Spaces for tabs (prettier default)
opt.shiftwidth = 2 -- 2 Spaces for indent width
opt.autoindent = true -- Copy indent from current line when starting a new one

-- Bye bye highlight on search
opt.hlsearch = false

-- Like incremental search
opt.incsearch = true

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
o.guicursor = "n-v-c:block,i-ci-ve:block,r-cr:hor20,o:hor50,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor,sm:block-blinkwait175-blinkoff150-blinkon175"

-- Highlight on yank
local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank()
	end,
	group = highlight_group,
	pattern = "*",
})

-- Remove Mouse interactions with Vim
opt.mouse = "a"

-- Transparency on my theme
vim.g.nightflyTransparent = false
