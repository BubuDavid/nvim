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
o.guicursor =
	"n-v-c:block,i-ci-ve:block,r-cr:hor20,o:hor50,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor,sm:block-blinkwait175-blinkoff150-blinkon175"

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

-- Set the colored line for 79 characters PEP-8
local function add_colorcolumn()
	opt.colorcolumn = "79"
end

-- Define a function to remove colorcolumn
local function remove_colorcolumn()
	vim.opt.colorcolumn = ""
end

-- Remove colorcolumn by default
remove_colorcolumn()

-- Remove colocolumn for avante
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "Avante*", "json", "conf", "neo-tree" },
	callback = remove_colorcolumn,
})

-- Set an autocommand for specific file types to add the colorcolumn
vim.api.nvim_create_autocmd("FileType", {
	pattern = {
		"python",
		"javascript",
		"javascriptreact",
		"typescript",
		"typescriptreact",
		"c",
		"cpp",
		"rust",
		"go",
		"lua",
	},
	callback = add_colorcolumn,
})

-- Set configfiles autocommand
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
	pattern = { ".env", ".env.example", ".env.test", ".env.test.example" },
	callback = function()
		vim.bo.filetype = "conf"
	end,
})

-- Avante recommended stuff
vim.opt.laststatus = 3

-- for open help in a different
vim.api.nvim_create_autocmd({ "FileType" }, {
	pattern = "help",
	callback = function()
		if vim.bo.filetype == "help" and #vim.api.nvim_list_wins() > 1 then
			vim.cmd("wincmd T")
			vim.api.nvim_buf_set_keymap(0, "n", "q", ":tabclose<CR>", {
				noremap = true,
				silent = true,
				desc = "Close help tab",
			})
		end
	end,
	group = vim.api.nvim_create_augroup("HelpInTabs", {
		clear = true,
	}),
})
