return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		-- import lspconfig plugin
		local lspconfig = require("lspconfig")

		local keymap = vim.keymap -- for conciseness

		local opts = { noremap = true, silent = true }
		local on_attach = function(_, bufnr)
			opts.buffer = bufnr

			-- set keybinds
			opts.desc = "Show LSP references"
			keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", opts) -- show definition, references

			opts.desc = "Go to declaration"
			keymap.set("n", "gD", vim.lsp.buf.declaration, opts) -- go to declaration

			opts.desc = "Show LSP definitions"
			keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts) -- show lsp definitions

			opts.desc = "Show LSP implementations"
			keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts) -- show lsp implementations

			opts.desc = "Show LSP type definitions"
			keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts) -- show lsp type definitions

			opts.desc = "See available code actions"
			keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts) -- see available code actions, in visual mode will apply to selection

			opts.desc = "Smart rename"
			keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts) -- smart rename

			opts.desc = "Show buffer diagnostics"
			keymap.set("n", "<leader>vD", "<cmd>Telescope diagnostics bufnr=0<CR>", opts) -- show  diagnostics for file

			opts.desc = "Show line diagnostics"
			keymap.set("n", "<leader>vd", vim.diagnostic.open_float, opts) -- show diagnostics for line

			opts.desc = "Go to previous diagnostic"
			keymap.set("n", "[d", vim.diagnostic.goto_prev, opts) -- jump to previous diagnostic in buffer

			opts.desc = "Go to next diagnostic"
			keymap.set("n", "]d", vim.diagnostic.goto_next, opts) -- jump to next diagnostic in buffer

			opts.desc = "Show documentation for what is under cursor"
			keymap.set("n", "K", vim.lsp.buf.hover, opts) -- show documentation for what is under cursor

			opts.desc = "Restart LSP"
			keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts) -- mapping to restart lsp if necessary
		end

		-- Change the Diagnostic symbols in the sign column (gutter)
		local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
		for type, icon in pairs(signs) do
			local hl = "DiagnosticSign" .. type
			vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
		end

		-- Setup pyright for Python
		lspconfig["pyright"].setup({
			on_attach = on_attach,
			settings = {
				python = {
					analysis = {
						diagnosticMode = "openFilesOnly",
						reportUnusedVariable = "none", -- This should disable the specific diagnostic
					},
				},
			},
			-- This is the important part - it tells Neovim to ignore "unnecessary" diagnostics
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
							local var_name =
								diagnostic.message:match('"([^"]+)" is not accessed')

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
					vim.lsp.handlers["textDocument/publishDiagnostics"](_, result, ctx, config)
				end,
			},
		})

		-- Setup lua_ls for Lua
		lspconfig["lua_ls"].setup({
			on_attach = on_attach,
			settings = {
				Lua = {
					diagnostics = {
						globals = { "vim" },
					},
					workspace = {
						library = vim.api.nvim_get_runtime_file("", true),
						checkThirdParty = false,
					},
					telemetry = { enable = false },
				},
			},
		})
	end,
}
