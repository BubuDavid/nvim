-- Here are all my basic keymaps --

vim.g.mapleader = " "

local set_keymap = function(mode, lhs, rhs, opts)
	if type(opts) == "string" then
		opts = {
			desc = opts
		}
	end

	vim.keymap.set(mode, lhs, rhs, opts)
end

set_keymap({ "n", "v" }, "}", "}zz", "Go to next empty line with centered cursor")
set_keymap({ "n", "v" }, "{", "{zz", "Go to previuos empty line with centered cursor")

set_keymap("n", "<leader>nn", vim.cmd.noh, "Remove highlight after search")

set_keymap("v", "K", ":m '<-2<CR>gv=gv", "Move Up the selected text")
set_keymap("v", "J", ":m '>+1<CR>gv=gv", "Move Down the selected text")

-- Window Commands
set_keymap("n", "<C-h>", "<C-w>h", { desc = "Go to Left Window", remap = true })
set_keymap("n", "<C-j>", "<C-w>j", { desc = "Go to Lower Window", remap = true })
set_keymap("n", "<C-k>", "<C-w>k", { desc = "Go to Upper Window", remap = true })
set_keymap("n", "<C-l>", "<C-w>l", { desc = "Go to Right Window", remap = true })
set_keymap("n", "<C-Up>", "<cmd>resize +2<cr>", "Increase Window Height")
set_keymap("n", "<C-Down>", "<cmd>resize -2<cr>", "Decrease Window Height")
set_keymap("n", "<C-Left>", "<cmd>vertical resize -2<cr>", "Decrease Window Width")
set_keymap("n", "<C-Right>", "<cmd>vertical resize +2<cr>", "Increase Window Width")

set_keymap("x", "<leader>p", '"_dP', "Delete something without copying it")
set_keymap("n", "<leader>d", '"_d', "Delete something without copying it")
set_keymap("v", "<leader>d", '"_d', "Delete something without copying it")

set_keymap("n", "<leader>Y", '"+y$', "Copy things from nvim to computer")
set_keymap({ "n", "v" }, "<leader>y", '"+y', "Copy things from nvim to computer")

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

set_keymap("n", "<leader>rn", function()
	vim.lsp.buf.rename()
end, "LSP Smart Rename")

set_keymap("n", "<leader>lr", ":LspRestart<CR>", "Restart the lsp")

set_keymap("n", "<leader><C-]>", function()
	local function on_list(options)
		vim.fn.setqflist({}, ' ', options)
		vim.cmd.tabnew()
		vim.cmd.cfirst()
	end
	vim.lsp.buf.definition({ on_list = on_list })
end, { desc = "Jumping to definition in another tab", })

-- VIM MOTIONS ON INSERT MODE
set_keymap("i", "<C-h>", "<C-\\><C-O>h", "Move left one word in insert mode")
set_keymap("i", "<C-l>", "<C-\\><C-O>l", "Move right one word in insert mode")
set_keymap("i", "<C-p>", "<C-\\><C-O>p", "Move right one word in insert mode")
set_keymap("i", "<C-d>", "<C-\\><C-O>x", "Delete character after cursor")

-- BUFFER NAVIGATION
set_keymap("n", "<leader>bd", vim.cmd.bd, "Delete buffer")
set_keymap("n", "<leader>bb", ":b#<CR>", "Go to previous buffer")
set_keymap("n", "<leader>bn", ":bn<CR>", "Rotate buffers with bufnext")


-- DEVELOPMENT
set_keymap("n", "<leader><leader>x", ":source %<CR>", "Executes a lua file")
set_keymap("n", "<leader>x", ":.lua<CR>", "Executes a lua line")
set_keymap("v", "<leader>x", ":lua<CR>", "Executes a lua selection")

-- TAB NAVIGATION
set_keymap("n", "<leader>tn", vim.cmd.tabn, "Go to next tab")
set_keymap("n", "<leader>tp", vim.cmd.tabp, "Go to next tab")
set_keymap("n", "<leader>tp", vim.cmd.tabp, "Go to next tab")

-- QUICKFIX NAVIGATION
set_keymap("n", "<leader>co", vim.cmd.copen, "Open quickfix list")
set_keymap("n", "<leader>cc", vim.cmd.cclose, "Close quickfix list")
set_keymap("n", "<leader>cn", vim.cmd.cnext, "Go to next quickfix item")
set_keymap("n", "<leader>cp", vim.cmd.cprev, "Go to previous quickfix item")
