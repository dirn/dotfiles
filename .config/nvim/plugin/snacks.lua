vim.schedule(function()
  vim.pack.add({
    "https://github.com/folke/lazydev.nvim",

    "https://github.com/nvim-lua/plenary.nvim",
    "https://github.com/folke/todo-comments.nvim",

    "https://github.com/folke/snacks.nvim",
  })

  require("lazydev").setup({
    library = {
      { path = "snacks.nvim", words = { "Snacks" } },
    },
  })

  require("todo-comments").setup()

  ---@class SnacksKeyMapping
  ---@field lhs string
  ---@field rhs fun()
  ---@field desc string

  ---@type SnacksKeyMapping[]
  local mappings = {
    {
      lhs = "<leader><leader>",
      rhs = Snacks.notifier.hide,
      desc = "Dismiss all notifications",
    },
    {
      lhs = "<c-s>",
      rhs = Snacks.picker.buffers,
      desc = "Search the open buffers.",
    },
    {
      lhs = "<leader>gb",
      rhs = Snacks.picker.grep_buffers,
      desc = "Search the contents of the open buffers.",
    },
    {
      lhs = "<leader>:",
      rhs = Snacks.picker.command_history,
      desc = "Search the command history.",
    },
    {
      lhs = "<leader>dg",
      rhs = Snacks.picker.diagnostics_buffer,
      desc = "Search the diagnostics for the current buffer.",
    },
    {
      lhs = "<c-p>",
      rhs = Snacks.picker.git_files,
      desc = "Search the files tracked by git.",
    },
    {
      lhs = "<leader>rg",
      rhs = Snacks.picker.grep,
      desc = "Grep for something.",
    },
    {
      lhs = "<leader>?",
      rhs = Snacks.picker.help,
      desc = "Search the help tags.",
    },
    {
      lhs = "<leader>km",
      rhs = Snacks.picker.keymaps,
      desc = "Search the keymappings.",
    },
    {
      lhs = "<leader>rc",
      rhs = Snacks.picker.recent,
      desc = "Search the recent files.",
    },
    {
      lhs = "<leader>/",
      rhs = Snacks.picker.search_history,
      desc = "Search the search history.",
    },
    {
      lhs = "<leader>td",
      -- Use a function here because the todo_comments picker comes from an extension.
      -- This only seems to be an issue when running headless (which I do from my
      -- bootstrap script). This happens regardless of whether or not vim.schedule is
      -- used.
      rhs = function()
        Snacks.picker.todo_comments()
      end,
      desc = "Search for TODO comments.",
    },
    {
      lhs = "<leader>s",
      -- Use a function here because lua_ls doesn't see Snacks.scratch as a function.
      rhs = function()
        Snacks.scratch()
      end,
      desc = "Toggle a scratch buffer.",
    },
    {
      lhs = "<leader>S",
      rhs = Snacks.scratch.select,
      desc = "Select a scratch buffer.",
    },
  }

  for _, mapping in ipairs(mappings) do
    vim.keymap.set(
      "n",
      mapping.lhs,
      mapping.rhs,
      { desc = mapping.desc, silent = true }
    )
  end

  require("snacks").setup({
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
    quickfile = {},
    scratch = {},
  })
end)
