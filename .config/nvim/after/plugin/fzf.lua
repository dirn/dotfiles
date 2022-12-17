local options = { noremap = true, silent = true }

-- Fuzzy find files.
vim.keymap.set("n", "<c-p>", vim.cmd.GitFiles, options)
vim.keymap.set("n", "<leader>rg", vim.cmd.Rg, options)
vim.keymap.set("n", "<leader>ls", vim.cmd.Buffers, options)
