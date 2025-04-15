-- This is for the servers that do not support formatting by default
vim.api.nvim_create_autocmd("FileType", {
	group = vim.api.nvim_create_augroup("PythonFormattingGroup", { clear = true }),
	pattern = "python",
	callback = function()
		vim.keymap.set({ "n" }, "<leader>mp", function()
			-- Get current buffer content
			local bufnr = vim.api.nvim_get_current_buf()
			local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
			local content = table.concat(lines, "\n")

			-- Format with isort through stdin/stdout
			local import_sort_cmd = "ruff check --select I --fix --silent -"
			local import_sort_output = vim.fn.system(import_sort_cmd, content)

			-- Check if isort succeeded
			if vim.v.shell_error ~= 0 then
				print("Sort imports failed: " .. import_sort_output)
				return
			end
			-- Format with ruff through stdin/stdout
			local format_cmd = "ruff format --silent -"
			local formatted_content = vim.fn.system(format_cmd, import_sort_output)

			-- Check if ruff succeeded
			if vim.v.shell_error ~= 0 then
				print("format failed: " .. formatted_content)
				return
			end

			-- Properly split the formatted content into lines, preserving empty lines
			local formatted_lines = vim.split(formatted_content, "\n", { plain = true })

			-- Remove trailing empty line that might be added by formatters
			if formatted_lines[#formatted_lines] == "" then
				table.remove(formatted_lines)
			end

			-- Replace buffer content with formatted content
			vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, formatted_lines)

			print("Formatted with ruff ✨")
		end, { desc = "Simple usage of ruff", buffer = true })
	end

})
