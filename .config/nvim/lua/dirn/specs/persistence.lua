return {
  "https://github.com/folke/persistence.nvim",
  event = "BufReadPre",
  opts = {},
  init = function()
    vim.api.nvim_create_autocmd("FileType", {
      group = vim.api.nvim_create_augroup("do-not-persist", { clear = true }),
      pattern = { "diff", "gitcommit", "gitrebase", "mail" },
      callback = function()
        require("persistence").stop()
      end,
    })
  end,
}
