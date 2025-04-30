local function base_format(format_fn, opts)
	MiniTrailspace.trim()
	if format_fn == nil then
		print("Formatted using vim.lsp.buf.format() ✨")
		vim.lsp.buf.format()
	else
		format_fn(opts)
	end
end

vim.keymap.set("n", "<leader>mp", function()
	base_format()
end, { desc = "Making pretty command" })

-- ================== PYTHON ================== --
local function python_format()
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
end

-- This is for the servers that do not support formatting by default
vim.api.nvim_create_autocmd("FileType", {
	group = vim.api.nvim_create_augroup("PythonFormattingGroup", { clear = true }),
	pattern = "python",
	callback = function()
		vim.keymap.set({ "n" }, "<leader>mp", function()
			base_format(python_format)
		end, { desc = "Simple usage of ruff", buffer = true })
	end
})


-- ================== PRETTIER ================== --
local function prettier_format(opts)
	opts = opts or {}
	local filetype = opts.filetype or vim.bo.filetype

	-- Get current buffer content
	local bufnr = vim.api.nvim_get_current_buf()
	local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
	local content = table.concat(lines, "\n")

	-- Prepare prettier command with plugin search dir for global plugins
	local plugin_flag = ""
	if filetype == "toml" then
		plugin_flag =
		"--plugin=/opt/node-current/lib/node_modules/prettier-plugin-toml/lib/index.cjs"
	end

	-- Format with prettier through stdin/stdout
	local format_cmd = string.format("prettier --stdin-filepath dummy.%s %s", filetype, plugin_flag)
	local formatted_content = vim.fn.system(format_cmd, content)

	-- Check if prettier succeeded
	if vim.v.shell_error ~= 0 then
		print("Prettier formatting failed: " .. formatted_content)
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

	print("Formatted with prettier ✨")
end

vim.api.nvim_create_autocmd("FileType", {
	group = vim.api.nvim_create_augroup("PrettierFormattingGroup", { clear = true }),
	pattern = {
		"html",
		"css",
		"javascript",
		"javascriptreact",
		"typescript",
		"typescriptreact",
		"json",
		"toml",
		"yaml",
		"markdown"
	},
	callback = function()
		vim.keymap.set({ "n" }, "<leader>mp", function()
			local filetype = vim.bo.filetype -- Here detects the filetype of the current buffer
			if filetype == "yaml.docker-compose" then
				base_format()
			else
				base_format(prettier_format, { filetype = filetype })
			end
		end, { desc = "Simple usage of prettier", buffer = true })
	end
})
