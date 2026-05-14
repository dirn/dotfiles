load_on({ "BufReadPost", "BufNewFile" }, function()
  vim.pack.add({
    "https://github.com/numToStr/Comment.nvim",
  })

  require("comment").setup()
end)
