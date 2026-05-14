load_on("BufWritePre", function()
  vim.pack.add({
    "https://github.com/stevearc/conform.nvim",
  })

  require("conform").setup({
    format_on_save = { lsp_format = "fallback", timeout_ms = 5000 },
    formatters_by_ft = {
      fish = { "fish_indent" },
      lua = { "stylua" },
      python = { "ruff_fix", "ruff_format", "ruff_organize_imports" },
      yaml = { "prettier" },
    },
  })
end)
