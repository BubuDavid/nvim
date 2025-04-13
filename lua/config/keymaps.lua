-- Here are all my basic keymaps --

vim.g.mapleader = " "

local set_keymap = function(mode, lhs, rhs, desc)
	vim.keymap.set(mode, lhs, rhs, { desc = desc })
end

set_keymap({ "n", "v" }, "}", "}zz", "Go to next empty line with centered cursor")
set_keymap({ "n", "v" }, "{", "{zz", "Go to previuos empty line with centered cursor")

set_keymap("n", "<leader>nn", vim.cmd.noh, "Remove highlight after search")

set_keymap("v", "K", ":m '<-2<CR>gv=gv", "Move Up the selected text")
set_keymap("v", "J", ":m '>+1<CR>gv=gv", "Move Down the selected text")

set_keymap("x", "<leader>p", '"_dP', "Delete something without copying it")
set_keymap("n", "<leader>d", '"_d', "Delete something without copying it")
set_keymap("v", "<leader>d", '"_d', "Delete something without copying it")

set_keymap("n", "<leader>Y", '"+y$', "Copy things from nvim to computer")
set_keymap({ "n", "v" }, "<leader>y", '"+y', "Copy things from nvim to computer")

set_keymap("n", "<leader>bd", vim.cmd.bd, "Delete buffer")

set_keymap("n", "cgn", "*Ncgn", "Changes the current word and with '.' changes the following match")
set_keymap("n", "g.", [[:/\V\C<C-R>"<CR>cgn<C-A><Esc>]], "cgn but if you forget the cgn")

set_keymap("n", "gi", "gi<ESC>lzz", "Go to last insert in the buffer and escape and stay in normal mode")

-- LSP STUFF
set_keymap("n", "K", function()
	vim.lsp.buf.hover({ border = "rounded" })
end, "Hover info under cursor")

set_keymap("n", "<leader>vd", function()
	vim.diagnostic.open_float({ border = "rounded" })
end, "Diagnostics")

set_keymap("n", "<leader>mp", function()
	print("Formatted ✨")
	vim.lsp.buf.format()
end, "Making pretty command")

set_keymap("n", "<leader>rn", function()
	vim.lsp.buf.rename()
end, "LSP Smart Rename")

-- VIM MOTIONS ON INSERT MODE
set_keymap("i", "<C-j>", "<C-\\><C-O>h", "Move left one space in insert mode")
set_keymap("i", "<C-h>", "<C-\\><C-O>b", "Move left one word in insert mode")
set_keymap("i", "<C-l>", "<C-\\><C-O>e", "Move right one word in insert mode")
set_keymap("i", "<C-p>", "<C-\\><C-O>p", "Move right one word in insert mode")
set_keymap("i", "<C-d>", "<C-\\><C-O>x", "Delete character after cursor")

-- BUFFER NAVIGATION
set_keymap("n", "<leader>fb", ":buffers<CR>", "List all buffers")
set_keymap("n", "<leader>1", ":b#<CR>", "Go to previous buffer")
set_keymap("n", "<leader>2", ":bn<CR>", "Rotate buffers with bufnext")


-- DEVELOPMENT
set_keymap("n", "<leader><leader>x", ":source %<CR>", "Executes a lua file")
set_keymap("n", "<leader>x", ":.lua<CR>", "Executes a lua line")
set_keymap("v", "<leader>x", ":lua<CR>", "Executes a lua selection")
