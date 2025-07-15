return {
  "https://github.com/folke/snacks.nvim",
  lazy = false, -- Keymaps make plugins lazy. This makes it eager to make `:lua Snacks` work.
  keys = {
    {
      "<leader><leader>",
      function()
        Snacks.notifier.hide()
      end,
      desc = "Dismiss all notifications",
      noremap = true,
      silent = true,
    },
    {
      "<leader>ls",
      function()
        Snacks.picker.buffers()
      end,
      desc = "Search the open buffers.",
      noremap = true,
      silent = true,
    },
    {
      "<leader>gb",
      function()
        Snacks.picker.grep_buffers()
      end,
      desc = "Search the contents of the open buffers.",
      noremap = true,
      silent = true,
    },
    {
      "<leader>:",
      function()
        Snacks.picker.command_history()
      end,
      desc = "Search the command history.",
      noremap = true,
      silent = true,
    },
    {
      "<leader>dg",
      function()
        Snacks.picker.diagnostics_buffer()
      end,
      desc = "Search the diagnostics for the current buffer.",
      noremap = true,
      silent = true,
    },
    {
      "<c-p>",
      function()
        Snacks.picker.git_files()
      end,
      desc = "Search the files tracked by git.",
      noremap = true,
      silent = true,
    },
    {
      "<leader>rg",
      function()
        Snacks.picker.grep()
      end,
      desc = "Grep for something.",
      noremap = true,
      silent = true,
    },
    {
      "<leader>?",
      function()
        Snacks.picker.grep()
      end,
      desc = "Search the help tags.",
      noremap = true,
      silent = true,
    },
    {
      "<leader>km",
      function()
        Snacks.picker.grep()
      end,
      desc = "Search the keymappings.",
      noremap = true,
      silent = true,
    },
    {
      "<leader>rc",
      function()
        Snacks.picker.grep()
      end,
      desc = "Search the recent files.",
      noremap = true,
      silent = true,
    },
    -- NOTE: This behaves differently than it did in telescope; it doesn't automatically
    -- paste what's in the register. I tried playing around with it and it never really
    -- seemed to work for me. All that said, I can't remember a time when I actually use
    -- this one so I might just pull it out.
    {
      "<leader>cp",
      function()
        Snacks.picker.registers()
      end,
      desc = "Search the registers.",
      noremap = true,
      silent = true,
    },
    {
      "<leader>/",
      function()
        Snacks.picker.search_history()
      end,
      desc = "Search the search history.",
      noremap = true,
      silent = true,
    },
    {
      "<leader>td",
      function()
        Snacks.picker.todo_comments()
      end,
      desc = "Search for TODO comments.",
      noremap = true,
      silent = true,
    },
  },
  opts = {
    notifier = {
      style = "compact",
    },
    picker = {
      layout = "ivy",
      win = {
        input = {
          keys = {
            ["<Esc>"] = { "close", mode = { "n", "i" } },
          },
        },
      },
    },
  },
}
