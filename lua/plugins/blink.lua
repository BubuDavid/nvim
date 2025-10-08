return {
  "saghen/blink.cmp",
  opts = {
    keymap = {
      preset = "default",
    },
    appearance = {
      nerd_font_variant = "mono",
    },
    completion = {
      documentation = {
        auto_show = true,
        window = { border = "rounded" },
      },
      menu = {
        border = "rounded",
      },
    },
    signature = {
      enabled = true,
      window = {
        border = "rounded",
      },
    },
    cmdline = {
      completion = {
        menu = {
          auto_show = true,
        },
      },
    },
    fuzzy = { frecency = { enabled = true } },
  },
  -- Sometimes the db for frecency gets corrupted and I need to delete the blink/ folder inside this path:
  -- print(vim.fn.stdpath('state') .. '/blink/cmp/frecency.dat')
}
