vim.pack.add({
  "https://github.com/goolord/alpha-nvim",
})

local alpha = require("alpha")
local config = require("dirn.dashboard").config

alpha.setup(config)

vim.keymap.set("n", "<leader>ds", function()
  alpha.start(false, config)
end, {
  desc = "Show the dashboard.",
})
