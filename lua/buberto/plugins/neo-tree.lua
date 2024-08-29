-- Unless you are still migrating, remove the deprecated commands from v1.x
vim.cmd [[ let g:neo_tree_remove_legacy_commands = 1 ]]
vim.keymap.set("n", "<leader>tr", ":Neotree toggle current<CR>", {})
vim.keymap.set("n", "<leader>tb", ":Neotree buffers toggle current reveal<CR>", {})

return {
  "nvim-neo-tree/neo-tree.nvim",
  version = "*",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
    "MunifTanjim/nui.nvim",
  },
  config = function()
    require("neo-tree").setup {
      event_handlers = {
        {
          event = "file_opened",
          handler = function()
            require("neo-tree.command").execute { action = "close" }
          end,
        },
      },
      source_selector = {
        winbar = true,
        statusline = false,
      },
      filesystem = {
        hijack_netrw_behavior = "open_current",
      },
    }
  end,
}
