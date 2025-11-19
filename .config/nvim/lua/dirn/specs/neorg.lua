-- Dependencies
-- plenary.nvim

return {
  "https://github.com/nvim-neorg/neorg",
  opts = {
    load = {
      ["core.defaults"] = {},
      ["core.completion"] = { config = { engine = "nvim-cmp" } },
      ["core.concealer"] = {
        config = {
          icons = {
            todo = {
              cancelled = { icon = "_" },
              done = { icon = "x" },
              enabled = { icon = "e" },
              on_hold = { icon = "=" },
              pending = { icon = "-" },
              recurring = { icon = "+" },
              uncertain = { icon = "?" },
              undone = { icon = " " },
              urgent = { icon = "!" },
            },
          },
        },
      },
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
