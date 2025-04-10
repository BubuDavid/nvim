vim.g.mapleader = " "
vim.g.copilot_no_tab_map = true
vim.g.copilot_assume_mapped = true

local set_keymap = function(mode, input, action, desc, noremap)
	if noremap then
		vim.keymap.set(mode, input, action, { desc = desc, noremap = noremap })
	else
		vim.keymap.set(mode, input, action, { desc = desc })
	end
end

-- Go to empty line with center cursor
set_keymap("n", "}", "}zz", "Go to next empty line with center cursor")
set_keymap("n", "{", "{zz", "Go to previous empty line with center cursor")

-- Open Explorer
set_keymap({ "n", "v" }, "<leader>pv", vim.cmd.Exp, "Open the explorer")

-- Bye bye highlight on search
set_keymap("n", "<leader>nn", "<cmd>noh<CR>")

-- Move while highlighting
set_keymap("v", "J", ":m '>+1<CR>gv=gv", "Move Down the selected text")
set_keymap("v", "K", ":m '<-2<CR>gv=gv", "Move Up the selected text")

-- Deleting something without copying it
set_keymap("x", "<leader>p", '"_dP', "Delete something without copying it")
set_keymap("n", "<leader>d", '"_d', "Delete something without copying it")
set_keymap("v", "<leader>d", '"_d', "Delete something without copying it")

-- Copying things from nvim to computer
set_keymap("n", "<leader>y", '"+y', "Copy things from nvim to computer")
set_keymap("n", "<leader>Y", '"+Y', "Copy things from nvim to computer")
set_keymap("v", "<leader>y", '"+y', "Copy things from nvim to computer")

-- Travel between buffers
-- set_keymap({ "n", "v" }, "<tab>", vim.cmd.bn, "Go to next buffer")
-- set_keymap({ "n", "v" }, "<S-tab>", vim.cmd.bp, "Go to previous buffer")

-- Map the jump motions correctly
set_keymap("n", "<C-o>", "<C-o>", "Go to previous jump element", true)
set_keymap("n", "<C-i>", "<C-i>", "Go to next jump element", true)

-- Delete buffer
set_keymap("n", "<leader>bd", vim.cmd.bd, "Delete buffer")

-- Go to defition and make the cursor at the top of the screen
-- set_keymap("n", "gd", "gdzt", "Go to definition and make the cursor at the top of the screen")

-- After control + d, the cursor will be at the center of the screen
set_keymap("n", "<C-d>", "<C-d>zz", "After control + d, the cursor will be at the center of the screen")
-- After control + u, the cursor will be at the center of the screen
set_keymap("n", "<C-u>", "<C-u>zz", "After control + u, the cursor will be at the center of the screen")

-- Selection actions to auto cgn word under cursor
set_keymap("n", "cgn", "*Ncgn")
-- If I forgot to do the last command (and do something like ciw), this command cgn from the last modified word
set_keymap("n", "g.", [[:/\V\C<C-R>"<CR>cgn<C-A><Esc>]], "cgn but if you forget the cgn", true)

-- Tab actions
set_keymap("n", "<leader>>", ":tabn<CR>", "Go to next tab")
set_keymap("n", "<leader><", ":tabp<CR>", "Go to previous tab")

-- Fun replace of under the cursor word globally
set_keymap(
	"n",
	"<leader>rg",
	[[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gc<Left><Left><Left>]],
	"Replace under the cursor word automatically"
)

-- DEV
set_keymap("n", "<leader><leader>x", ":so %<CR>", "Execute lua file")
