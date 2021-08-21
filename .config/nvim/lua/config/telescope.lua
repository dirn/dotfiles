local noremap = require("config").noremap
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

noremap(
  "n",
  "<leader>bf",
  "<cmd>lua require('telescope.builtin').current_buffer_fuzzy_find()<cr>"
)
noremap(
  "n",
  "<leader>h",
  "<cmd>lua require('telescope.builtin').help_tags()<cr>"
)
noremap(
  "n",
  "<leader>km",
  "<cmd>lua require('telescope.builtin').keymaps()<cr>"
)
noremap(
  "n",
  "<leader>cp",
  "<cmd>lua require('telescope.builtin').registers()<cr>"
)
noremap(
  "n",
  "<leader>/",
  "<cmd>lua require('telescope.builtin').search_history()<cr>"
)
