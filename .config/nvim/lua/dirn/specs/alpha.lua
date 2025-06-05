return {
  "https://github.com/goolord/alpha-nvim",
  config = function()
    local alpha = require("alpha")
    local config = require("dirn.dashboard").config

    alpha.setup(config)

    vim.keymap.set("n", "<leader>d", function()
      alpha.start(false, config)
    end, {
      desc = "Show the dashboard.",
    })
  end,
}
