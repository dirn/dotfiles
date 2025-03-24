return {
  "https://github.com/goolord/alpha-nvim",
  config = function()
    require("alpha").setup(require("dirn.dashboard").config)
  end,
}
