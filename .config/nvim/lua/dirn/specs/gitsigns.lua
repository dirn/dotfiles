-- Dependencies
-- plenary.nvim

return {
  "https://github.com/lewis6991/gitsigns.nvim",
  cond = function()
    return os.getenv("NVIM_DISABLE_GITSIGNS") == nil
  end,
  opts = {
    _on_attach_pre = function(bufnr, callback)
      require("gitsigns-yadm").yadm_signs(callback, { bufnr = bufnr })
    end,
    signs = {
      add = {
        text = "+",
      },
      change = {
        text = "~",
      },
      delete = {
        text = "_",
      },
      topdelete = {
        text = "‾",
      },
      changedelete = {
        text = "~_",
      },
    },
  },
}
