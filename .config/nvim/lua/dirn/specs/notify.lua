return {
  "https://github.com/rcarriga/nvim-notify",
  config = function()
    vim.keymap.set("n", "<leader><leader>", function()
      require("notify").dismiss({ silent = true, pending = true })
    end, {
      desc = "Dismiss all notifications",
      noremap = true,
      silent = true,
    })
  end,
}
