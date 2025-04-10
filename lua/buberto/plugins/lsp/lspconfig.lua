return {
	"neovim/nvim-lspconfig",
	dependencies = {
		"saghen/blink.cmp",
		{
			"folke/lazydev.nvim",
			opts = {
				library = {
					{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
				},
			},
		},
	},
	enabled = true,
	event = { "BufReadPre", "BufNewFile" },
	opts = {
		servers = {
			lua_ls = {},
			pyright = {
				handlers = {
					["textDocument/publishDiagnostics"] = function(_, result, ctx, config)
						local filtered_diagnostics = {}
						for _, diagnostic in ipairs(result.diagnostics) do
							-- Keep the diagnostic unless it's an unused variable with __ prefix
							local keep = true

							-- Check if it's an "unnecessary" diagnostic (tag==1) for an unused variable
							if
								diagnostic.tags
								and diagnostic.tags[1] == 1
								and diagnostic.message:match("is not accessed")
							then
								-- Extract the variable name from the message
								local var_name = diagnostic.message:match(
									'"([^"]+)" is not accessed'
								)

								-- Skip if the variable starts with __ (dunder)
								if var_name and var_name:match("^_") then
									keep = false
								end
							end

							if keep then
								table.insert(filtered_diagnostics, diagnostic)
							end
						end

						result.diagnostics = filtered_diagnostics
						vim.lsp.handlers["textDocument/publishDiagnostics"](
							_,
							result,
							ctx,
							config
						)
					end,
				},
			},
			ts_ls = {},
			tailwindcss = {},
		},
	},
	config = function(_, opts)
		local lspconfig = require("lspconfig")

		vim.diagnostic.config({
			signs = {
				text = {
					[vim.diagnostic.severity.ERROR] = " ",
					[vim.diagnostic.severity.WARN] = " ",
					[vim.diagnostic.severity.HINT] = "󰠠 ",
					[vim.diagnostic.severity.INFO] = " ",
				},
			},
		})

		for server, config in pairs(opts.servers) do
			config.capabilities = require("blink.cmp").get_lsp_capabilities(config.capabilities)
			lspconfig[server].setup(config)
		end
	end,
}
