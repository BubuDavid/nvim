return {
	"stevearc/conform.nvim",
	lazy = true,
	event = { "BufReadPre", "BufNewFile" }, -- to disable, comment this out
	config = function()
		local conform = require("conform")

		-- Function to get Poetry executable path
		local function get_poetry_cmd(cmd)
			-- Check if we're in a Poetry project by looking for pyproject.toml
			local project_dir = vim.fn.getcwd()
			if vim.fn.filereadable(project_dir .. "/pyproject.toml") == 1 then
				return { "poetry", "run", cmd }
			else
				return { cmd }
			end
		end
		-- Configure formatters to use Poetry when available
		conform.formatters.black = {
			command = get_poetry_cmd("black")[1],
			args = function()
				local args = { "--quiet" }
				-- Add your custom args
				table.insert(args, "--line-length")
				table.insert(args, "79")

				-- If we're in a Poetry project, prepend "run" and the command
				if get_poetry_cmd("black")[1] == "poetry" then
					table.insert(args, 1, "black")
					table.insert(args, 1, "run")
				end

				return args
			end,
		}

		conform.formatters.isort = {
			command = get_poetry_cmd("isort")[1],
			args = function()
				local args = {}

				-- If we're in a Poetry project, prepend "run" and the command
				if get_poetry_cmd("isort")[1] == "poetry" then
					table.insert(args, "run")
					table.insert(args, "isort")
				end

				-- Any additional isort args can be added here
				table.insert(args, "--profile")
				table.insert(args, "black")

				return args
			end,
		}

		conform.setup({
			formatters_by_ft = {
				svelte = { "prettier" },
				javascript = { "prettier" },
				typescript = { "prettier" },
				javascriptreact = { "prettier" },
				typescriptreact = { "prettier" },
				css = { "prettier" },
				html = { "prettier" },
				json = { "prettier" },
				yaml = { "prettier" },
				-- markdown = { "prettier" },
				lua = { "stylua" },
				python = { "isort", "black" },
				c = { "clang-format" },
			},
		})

		vim.keymap.set({ "n", "v" }, "<leader>mp", function()
			print("Formatted ✨")
			conform.format({
				lsp_fallback = true,
				async = false,
				timeout_ms = 1000,
			})
		end, { desc = "Format file or range (in visual mode)" })
	end,
}
