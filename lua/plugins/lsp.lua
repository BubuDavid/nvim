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
			pyright = {
				settings = {
					python = {
						analysis = {
							diagnosticMode = "workspace"
						}
					}
				},
				handlers = {
					["textDocument/publishDiagnostics"] = function(_, result, ctx, config)
						local filtered_diagnostics = {}
						for _, diagnostic in ipairs(result.diagnostics) do
							local keep = true

							if
									diagnostic.tags
									and diagnostic.tags[1] == 1
									and diagnostic.message:match("is not accessed")
							then
								local var_name = diagnostic.message:match(
									'"([^"]+)" is not accessed'
								)

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
					-- Disable progress notifications for pyright specifically
					["$/progress"] = function() end,
				},
			},
			lua_ls = {},
			ts_ls = {},
			tailwindcss = {},
			rust_analyzer = {},
			terraformls = {},
			docker_compose_language_service = {},
		},
	},
	config = function(_, opts)
		-- Disable progress notifications globally for ALL LSP servers
		vim.lsp.handlers["$/progress"] = function() end
		
		vim.diagnostic.config({
			signs = {
				text = {
					[vim.diagnostic.severity.ERROR] = " ",
					[vim.diagnostic.severity.WARN] = " ",
					[vim.diagnostic.severity.HINT] = "󰠠 ",
					[vim.diagnostic.severity.INFO] = " ",
				},
			},
		})

		vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
			group = vim.api.nvim_create_augroup("DockerComposeLSP", { clear = true }),
			pattern = { "docker-compose.{yml,yaml}" },
			callback = function()
				vim.bo.filetype = "yaml.docker-compose"
			end
		})

		for server, config in pairs(opts.servers) do
			config.capabilities = require("blink.cmp").get_lsp_capabilities(config.capabilities)
			vim.lsp.config(server, config)
			vim.lsp.enable(server)
		end
	end,
}
