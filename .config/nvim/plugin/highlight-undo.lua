load_on({ "BufReadPost", "BufNewFile" }, function()
  vim.pack.add({
    "https://github.com/tzachar/highlight-undo.nvim",
  })

  require("highlight-undo").setup()
end)
