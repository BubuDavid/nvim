return {
	"zbirenbaum/copilot.lua",
	cmd = "Copilot",
	keys = { "<leader>ce" },
	config = function()
		require('copilot').setup({
			panel = {
				enabled = true,
				auto_refresh = false,
				keymap = {
					jump_prev = "[[",
					jump_next = "]]",
					accept = "<CR>",
					refresh = "gr",
					open = "<M-CR>"
				},
				layout = {
					position = "right", -- | top | left | right | horizontal | vertical
					ratio = 0.5
				},
			},
			suggestion = {
				enabled = true,
				auto_trigger = true,
				hide_during_completion = true,
				debounce = 75,
				trigger_on_accept = true,
				keymap = {
					accept = "<C-a>",
					accept_word = "<C-j>",
					accept_line = "<C-l>",
					next = "<C-n>",
					prev = "<C-p>",
					dismiss = "<C-]>",
				},
			},
			filetypes = {
				yaml = true,
				markdown = true,
				help = false,
				gitcommit = true,
				gitrebase = false,
				hgcommit = false,
				svn = false,
				cvs = false,
				["."] = false,
			},
			auth_provider_url = nil, -- URL to authentication provider, if not "https://github.com/"
			logger = {
				file = vim.fn.stdpath("log") .. "/copilot-lua.log",
				file_log_level = vim.log.levels.OFF,
				print_log_level = vim.log.levels.WARN,
				trace_lsp = "off", -- "off" | "messages" | "verbose"
				trace_lsp_progress = false,
				log_lsp_messages = false,
			},
			copilot_node_command = 'node', -- Node.js version must be > 20
			workspace_folders = {},
			copilot_model = "",         -- Current LSP default is gpt-35-turbo, supports gpt-4o-copilot
			root_dir = function()
				return vim.fs.dirname(vim.fs.find(".git", { upward = true })[1])
			end,
			should_attach = function(_, _)
				if not vim.bo.buflisted then
					return false
				end

				if vim.bo.buftype ~= "" then
					return false
				end

				return true
			end,
			server = {
				type = "nodejs", -- "nodejs" | "binary"
				custom_server_filepath = nil,
			},
			server_opts_overrides = {},
		})

		vim.keymap.set("n", "<leader>ce", function()
			vim.cmd("Copilot enable")
			print("Copilot enabled 🤖")
		end, { desc = "Enable copilot" })

		vim.keymap.set("n", "<leader>cd", function()
			vim.cmd("Copilot disable")
			print("Copilot disabled 🫂")
		end, { desc = "Disable copilot" })
	end,
}
