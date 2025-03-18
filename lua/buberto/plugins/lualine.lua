return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		local lualine = require("lualine")
		local lazy_status = require("lazy.status") -- to configure lazy pending updates count

		local lint_progress = function()
			local linters = require("lint").get_running()
			if #linters == 0 then
					return "󰦕"
			end
			return "󱉶 " .. table.concat(linters, ", ")
		end

		-- configure lualine with modified theme
		lualine.setup({
			-- theme = "tokyonight",
			options = {
				icons_enabled = true,
				component_separators = { left = "|", right = "|" },
				section_separators = { left = "", right = "" },
			},
			sections = {
				lualine_c = {
					{ "filename", path = 1 },
					{
						lint_progress,
						color = { fg = "#ff9e64" },
					}
				},
				lualine_x = {
					{
						lazy_status.updates,
						cond = lazy_status.has_updates,
						color = { fg = "#ff9e64" },
					},
					{ "encoding" },
					{ "fileformat" },
					{ "filetype" },
				},
			},
		})
	end,
}
