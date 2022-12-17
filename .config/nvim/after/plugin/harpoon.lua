local options = { noremap = true, silent = true }

local ok, harpoon = pcall(require, "harpoon")
if not ok then
  return
end

harpoon.setup()

-- Add a mark for the current file.
vim.keymap.set("n", "<leader>ha", function()
  require("harpoon.mark").add_file()
end, options)

-- Navigate to marks.
for i = 1, 9 do
  vim.keymap.set("n", "<leader>h" .. i, function()
    require("harpoon.ui").nav_file(i)
  end, options)
end

-- See and edit existing marks.
vim.keymap.set("n", "<leader>ht", function()
  require("harpoon.ui").toggle_quick_menu()
end, options)
