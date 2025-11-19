-- Dependencies
-- plenary.nvim

return {
  "https://github.com/nvim-neorg/neorg",
  opts = {
    load = {
      ["core.defaults"] = {},
      ["core.completion"] = { config = { engine = "nvim-cmp" } },
      ["core.concealer"] = {},
      ["core.dirman"] = {
        config = {
          workspaces = {
            home = "~/.local/share/nvim/neorg/home",
            work = "~/.local/share/nvim/neorg/work",
          },
        },
      },
    },
  },
}
