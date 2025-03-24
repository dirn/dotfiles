return {
  "https://github.com/stevearc/conform.nvim",
  event = { "BufWritePre" },
  cmd = { "ConformInfo" },
  opts = {
    format_on_save = { lsp_fallback = true, timeout_ms = 5000 },
    formatters = {
      ruff_fix = {
        -- Enable isort-like behavior.
        prepend_args = { "--extend-select=I" },
      },
    },
    formatters_by_ft = {
      fish = { "fish_indent" },
      lua = { "stylua" },
      -- Let ruff make any changes before Black formats the code.
      python = { "ruff_format", "black" },
      yaml = { "prettier" },
    },
  },
}
