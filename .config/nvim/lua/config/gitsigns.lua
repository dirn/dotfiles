if os.getenv("NVIM_DISABLE_GITSIGNS") ~= nil then
  return
end

require("gitsigns").setup({
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
  yadm = {
    enable = true,
  },
})
