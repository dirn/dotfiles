vim.schedule(function()
  vim.pack.add({
    "https://github.com/obsidian-nvim/obsidian.nvim",
  })

  require("obsidian").setup({
    daily_notes = {
      folder = "daily",
      workdays_only = false,
    },
    footer = {
      enabled = false,
    },
    link = {
      style = "markdown",
    },
    note_id_func = require("obsidian.builtin").title_id,
    picker = {
      name = "snacks",
    },
    workspaces = {
      {
        name = "home",
        path = "~/.local/share/nvim/obsidian/home",
      },
      {
        name = "work",
        path = "~/.local/share/nvim/obsidian/work",
      },
    },
  })
end)
