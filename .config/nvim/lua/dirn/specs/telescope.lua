-- Dependencies
-- plenary.nvim
-- popup.nvim

return {
  "https://github.com/nvim-telescope/telescope.nvim",
  keys = {
    {
      "<leader>bf",
      function()
        require("telescope.builtin").buffers()
      end,
      desc = "List the open buffers.",
      noremap = true,
      silent = true,
    },
    {
      "<leader>:",
      function()
        require("telescope.builtin").command_history()
      end,
      desc = "List command history.",
      noremap = true,
      silent = true,
    },
    {
      "<leader>?",
      function()
        require("telescope.builtin").help_tags()
      end,
      desc = "List available help tags.",
      noremap = true,
      silent = true,
    },
    {
      "<leader>km",
      function()
        require("telescope.builtin").keymaps()
      end,
      desc = "List normal mode keymappings.",
      noremap = true,
      silent = true,
    },
    {
      "<leader>cp",
      function()
        require("telescope.builtin").registers()
      end,
      desc = "List registers, pasting the contents on <cr>.",
      noremap = true,
      silent = true,
    },
    {
      "<leader>/",
      function()
        require("telescope.builtin").search_history()
      end,
      desc = "List recently executed searches.",
      noremap = true,
      silent = true,
    },
  },
  config = function()
    local actions = require("telescope.actions")

    require("telescope").setup({
      defaults = {
        mappings = {
          i = {
            ["<esc>"] = actions.close,
          },
        },
      },
    })
  end,
}
