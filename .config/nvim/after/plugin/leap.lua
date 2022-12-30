local options = { noremap = true, silent = true }

vim.keymap.set({ "n", "o", "x" }, "<leader>f", "<Plug>(leap-forward)", options)
vim.keymap.set({ "n", "o", "x" }, "<leader>F", "<Plug>(leap-backward)", options)
