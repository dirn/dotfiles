local options = { noremap = true, silent = true }

local ok, telescope = pcall(require, "telescope")
if not ok then
  return
end

local actions = require("telescope.actions")

telescope.setup({
  defaults = {
    mappings = {
      i = {
        ["<esc>"] = actions.close,
      },
    },
  },
})

vim.keymap.set("n", "<leader>bf", function()
  require("telescope.builtin").current_buffer_fuzzy_find()
end, options)

vim.keymap.set("n", "<leader>h", function()
  require("telescope.builtin").help_tags()
end, options)

vim.keymap.set("n", "<leader>km", function()
  require("telescope.builtin").keymaps()
end, options)

vim.keymap.set("n", "<leader>cp", function()
  require("telescope.builtin").registers()
end, options)

vim.keymap.set("n", "<leader>/", function()
  require("telescope.builtin").search_history()
end, options)
