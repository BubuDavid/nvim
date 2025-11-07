return {
  "stevearc/conform.nvim",
  opts = {

    formatters_by_ft = {
      json = { "prettier" },
      python = { "ruff_organize_imports", "ruff_format" },
      toml = { "pyproject-fmt" },
      yaml = { "prettier" },
      html = { "prettier" },
    },
    formatters = {
      ruff_organize_imports = {
        command = "ruff",
        args = { "check", "--select", "I", "--fix", "--stdin-filename", "$FILENAME", "-" },
        stdin = true,
      },
    },
  },
}
