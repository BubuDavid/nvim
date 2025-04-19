return {
	"obsidian-nvim/obsidian.nvim",
	version = "*",
	-- event = {
	-- 	"BufReadPre " .. vim.fn.expand("~") .. "/vaults/**.md",
	-- 	"BufNewFile " .. vim.fn.expand("~") .. "/vaults/**.md",
	-- },
	dependencies = {
		"nvim-lua/plenary.nvim",
		"saghen/blink.cmp"
	},
	config = function()
		require("obsidian").setup({
			workspaces = {
				{
					name = "work",
					path = "~/notes/work"
				},
				{
					name = "learning",
					path = "~/notes/learning"
				},
				{
					name = "personal",
					path = "~/notes/personal"
				},
			},
			completion = {
				default = function() end,
				nvim_cmp = false,
				blink = true,
				min_chars = 2
			},
			---@param title string|?
			---@return string
			note_id_func = function(title)
				local suffix = ""
				if title ~= nil then
					-- If title is given, transform it into valid file name.
					suffix = title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
				else
					-- If title is nil, just add 4 random uppercase letters to the suffix.
					for _ = 1, 4 do
						suffix = suffix .. string.char(math.random(65, 90))
					end
				end
				return tostring(os.time()) .. "-" .. suffix
			end,
			wiki_link_func = function(opts)
				return " [[" .. opts["label"] .. "]]"
			end,
		})

		vim.keymap.set({ "n" }, "<leader>os", ":ObsidianSearch<CR>",
			{ desc = "Search by Grep the notes" })
		vim.keymap.set({ "n" }, "<leader>on", ":ObsidianNew<CR>",
			{ desc = "Create a note" })
		vim.keymap.set({ "n" }, "<leader>ow", ":ObsidianWorkspace<CR>",
			{ desc = "Change from workspace" })
		vim.keymap.set({ "n" }, "<leader>of", ":ObsidianQuickSwitch<CR>",
			{ desc = "Search note by name" })
		vim.keymap.set({ "n" }, "<leader>ob", ":ObsidianQuickSwitch<CR>",
			{ desc = "Get picker list of references to the current buffer" })
		vim.keymap.set({ "n" }, "<leader>ot", ":ObsidianTags<CR>",
			{ desc = "Search Tags" })
		vim.keymap.set({ "n" }, "<leader>or", ":ObsidianRename<CR>",
			{ desc = "Rename current note" })
		vim.keymap.set({ "n" }, "<leader>oc", ":ObsidianTOC<CR>",
			{ desc = "Open Table of Contents" })
	end
}
