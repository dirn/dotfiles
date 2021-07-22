local noremap = require("config").noremap
local silent = { silent = true }

require("harpoon").setup()

-- Add a mark for the current file.
noremap(
  "n",
  "<leader>ha",
  '<cmd>lua require("harpoon.mark").add_file()<cr>',
  silent
)

-- Navigate to marks.
for i = 1, 9 do
  noremap(
    "n",
    "<leader>h" .. i,
    '<cmd>lua require("harpoon.ui").nav_file(' .. i .. ")<cr>",
    silent
  )
end

-- See and edit existing marks.
noremap(
  "n",
  "<leader>ht",
  '<cmd>lua require("harpoon.ui").toggle_quick_menu()<cr>',
  silent
)
