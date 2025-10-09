-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = LazyVim.safe_keymap_set

map({ "n", "v" }, "<leader>mp", function()
  LazyVim.format({ force = true })
end, { desc = "Format" })

map({ "n", "v" }, "<leader>y", '"+y', { desc = "Copy to Systems clipboard" })
map({ "n", "v" }, "<leader>Y", '"+y$', { desc = "Copy to Systems clipboard until end of line" })

map({ "n", "v" }, "}", "}zz", { desc = "Go to next empty line with centered cursor" })
map({ "n", "v" }, "{", "{zz", { desc = "Go to previuos empty line with centered cursor" })

map("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move Up the selected text" })
map("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move Down the selected text" })

-- Unmap Alt+j and Alt+k for moving lines
vim.keymap.del("n", "<A-j>")
vim.keymap.del("n", "<A-k>")
vim.keymap.del("i", "<A-j>")
vim.keymap.del("i", "<A-k>")
vim.keymap.del("v", "<A-j>")
vim.keymap.del("v", "<A-k>")

map("x", "<leader>p", '"_dP', { desc = "Delete something without copying it" })
map("n", "<leader>d", '"_d', { desc = "Delete something without copying it" })
map("v", "<leader>d", '"_d', { desc = "Delete something without copying it" })

-- VIM MOTIONS ON INSERT MODE
map("i", "<C-h>", "<C-\\><C-O>h", { desc = "Move left one word in insert mode" })
map("i", "<C-l>", "<C-\\><C-O>l", { desc = "Move right one word in insert mode" })
map("i", "<C-p>", "<C-\\><C-O>p", { desc = "Move right one word in insert mode" })

map("i", "<C-d>", "<C-\\><C-O>x", { desc = "Delete character after cursor" })

map("n", "<leader>lu", ":Lazy update<CR>", { desc = "Update Lazy" })
