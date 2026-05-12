vim.schedule(function()
  vim.pack.add({
    "https://github.com/nvim-lua/plenary.nvim",
    "https://github.com/ruifm/gitlinker.nvim",
  })

  require("gitlinker").setup()
end)
