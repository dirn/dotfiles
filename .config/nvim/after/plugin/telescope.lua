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
end, { desc = "List the open buffers.", noremap = true, silent = true })

vim.keymap.set("n", "<leader>h", function()
  require("telescope.builtin").help_tags()
end, { desc = "List available help tags.", noremap = true, silent = true })

vim.keymap.set("n", "<leader>km", function()
  require("telescope.builtin").keymaps()
end, { desc = "List normal mode keymappings.", noremap = true, silent = true })

vim.keymap.set("n", "<leader>cp", function()
  require("telescope.builtin").registers()
end, {
  desc = "List registers, pasting the contents on <cr>.",
  noremap = true,
  silent = true,
})

vim.keymap.set(
  "n",
  "<leader>/",
  function()
    require("telescope.builtin").search_history()
  end,
  { desc = "List recently executed searches.", noremap = true, silent = true }
)
