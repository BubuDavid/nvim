vim.g.mapleader = " "

function set_keymap(mode, input, action, desc, noremap)
	if (noremap) then
		vim.keymap.set(mode, input, action, { desc = desc, noremap = noremap })
	else
		vim.keymap.set(mode, input, action, { desc = desc })
	end
end

-- Easy way of doing stuff (comment if you want to be old school)
-- set_keymap("i", "jk", "<ESC>", "Easy way to escape insert mode")
-- set_keymap("n", "<leader><space>", ":", "Easy way to access command mode")

-- Open Explorer
set_keymap({ "n", "v" }, "<leader>pv", vim.cmd.Exp, "Open the explorer")

-- Move while highlighting
set_keymap("v", "J", ":m '>+1<CR>gv=gv", "Move Down the selected text")
set_keymap("v", "K", ":m '<-2<CR>gv=gv", "Move Up the selected text")

-- Deleting something without copying it
set_keymap("x", "<leader>d", '"_dP', "Delete something without copying it")
set_keymap("n", "<leader>d", '"_d', "Delete something without copying it")
set_keymap("v", "<leader>d", '"_d', "Delete something without copying it")

-- Copying things from nvim to computer
set_keymap("n", "<leader>y", '"+y', "Copy things from nvim to computer")
set_keymap("n", "<leader>Y", '"+Y', "Copy things from nvim to computer")
set_keymap("v", "<leader>y", '"+y', "Copy things from nvim to computer")

-- Travel between buffers
set_keymap({ "n", "i" }, "<C-l>", vim.cmd.bn, "Go to next buffer")
set_keymap({ "n", "i" }, "<C-h>", vim.cmd.bp, "Go to previous buffer")

-- Selection actions to auto cgn word under cursor
set_keymap("n", "cgn", "*Ncgn")
-- If I forgot to do the last command (and do something like ciw), this command cgn from the last modified word
set_keymap("n", "g.", [[:/\V\C<C-R>"<CR>cgn<C-A><Esc>]], "cgn but if you forget the cgn", true)
