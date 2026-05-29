local mason_loaded = false

local function load_mason()
  if mason_loaded then
    return
  end

  vim.pack.add({
    "https://github.com/mason-org/mason.nvim",

    "https://github.com/neovim/nvim-lspconfig",
    "https://github.com/mason-org/mason-lspconfig.nvim",

    "https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim",
  })

  require("mason").setup()

  require("mason-lspconfig").setup()

  require("mason-tool-installer").setup({
    ensure_installed = {
      "diagnosticls",
      "lua-language-server",
      "mypy",
      "prettier",
      "ruff",
      "rust-analyzer",
      "stylua",
      "ty",
      "yamllint",
    },
  })

  mason_loaded = true
end

load_on({ "BufReadPost", "BufNewFile" }, load_mason)
load_on_user("AlphaReady", load_mason)
