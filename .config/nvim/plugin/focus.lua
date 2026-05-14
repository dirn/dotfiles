load_on("BufWinEnter", function()
  vim.pack.add({
    "https://github.com/beauwilliams/focus.nvim",
  })

  require("focus").setup()
end, { schedule = true })
