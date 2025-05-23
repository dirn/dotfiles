return {
  "https://github.com/stevearc/conform.nvim",
  event = { "BufWritePre" },
  cmd = { "ConformInfo" },
  opts = {
    format_on_save = { lsp_format = "fallback", timeout_ms = 5000 },
    formatters_by_ft = {
      fish = { "fish_indent" },
      lua = { "stylua" },
      -- Let ruff make any changes before Black formats the code.
      python = { lsp_format = "first" },
      yaml = { "prettier" },
    },
  },
}
