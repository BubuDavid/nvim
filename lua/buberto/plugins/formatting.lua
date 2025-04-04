return {
	"stevearc/conform.nvim",
	lazy = true,
	event = { "BufReadPre", "BufNewFile" }, -- to disable, comment this out
	config = function()
		local conform = require("conform")

		conform.setup({
			formatters_by_ft = {
				svelte = { "eslint_d", "prettier" },
				javascript = { "eslint_d", "prettier" },
				typescript = { "eslint_d", "prettier" },
				javascriptreact = { "eslint_d", "prettier" },
				typescriptreact = { "eslint_d", "prettier" },
				css = { "eslint_d", "prettier" },
				html = { "eslint_d", "prettier" },
				json = { "eslint_d", "prettier" },
				yaml = { "eslint_d", "prettier" },
				lua = { "stylua" },
				c = { "clang-format" },
				toml = { "pyproject-fmt" },
				python = { "isort", "black" },
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
