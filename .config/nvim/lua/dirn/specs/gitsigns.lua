return {
  "https://github.com/lewis6991/gitsigns.nvim",
  dependencies = {
    "https://github.com/purarue/gitsigns-yadm.nvim",
    "https://github.com/nvim-lua/plenary.nvim",
  },
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
