return {
	"mfussenegger/nvim-lint",
	lazy = true,
	event = { "BufReadPre", "BufNewFile" }, -- to disable, comment this out
	config = function()
		local lint = require("lint")

		-- Setup linting for Python with special handling
		lint.linters.pylint.cmd = function()
			-- Use the .venv in the current directory if it exists
			local venv_path = vim.fn.getcwd() .. "/.venv/bin/pylint"
			if vim.fn.filereadable(venv_path) == 1 then
				return venv_path
			end
			-- Fallback to the system pylint if .venv does not exist
			return "pylint"
		end

		lint.linters_by_ft = {
			javascript = { "eslint_d" },
			typescript = { "eslint_d" },
			javascriptreact = { "eslint_d" },
			typescriptreact = { "eslint_d" },
			svelte = { "eslint_d" },
			python = { "pylint" },
			c = { "cpplint" }, -- To configure filewise options create CPPLINT.cfg file
			cpp = { "cpplint" }, -- To configure filewise options create CPPLINT.cfg file
		}

		local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

		vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
			group = lint_augroup,
			callback = function()
				lint.try_lint()
			end,
		})

		vim.keymap.set("n", "<leader>li", function()
			lint.try_lint()
		end, { desc = "Trigger linting for current file" })
	end,
}
