local noremap = { noremap = true }
local silent = { silent = true }
local options = vim.tbl_extend("keep", noremap, silent)

vim.keymap.set("i", "jk", "<esc>")

vim.keymap.set("n", "<leader>Q", "<cmd>%bdelete<cr>")

-- The following set of previous/next/first/last mappings are inspired by
-- (borrowed from) https://github.com/tpope/vim-unimpaired.
-- Navigate buffers.
vim.keymap.set("n", "[b", vim.cmd.bprevious, options)
vim.keymap.set("n", "]b", vim.cmd.bnext, options)
vim.keymap.set("n", "[B", vim.cmd.bfirst, options)
vim.keymap.set("n", "]B", vim.cmd.blast, options)

-- Navigate the location list.
vim.keymap.set("n", "[l", vim.cmd.lprevious, options)
vim.keymap.set("n", "]l", vim.cmd.lnext, options)
vim.keymap.set("n", "[L", vim.cmd.lfirst, options)
vim.keymap.set("n", "]L", vim.cmd.llast, options)

-- Navigate the quickfix list.
vim.keymap.set("n", "[q", vim.cmd.qprevious, options)
vim.keymap.set("n", "]q", vim.cmd.qnext, options)
vim.keymap.set("n", "[Q", vim.cmd.qfirst, options)
vim.keymap.set("n", "]Q", vim.cmd.qlast, options)

-- Navigate tabs (these differ from vim-unimpaired).
vim.keymap.set("n", "[t", vim.cmd.tprevious, options)
vim.keymap.set("n", "]t", vim.cmd.tnext, options)
vim.keymap.set("n", "[T", vim.cmd.tfirst, options)
vim.keymap.set("n", "]T", vim.cmd.tlast, options)

-- Copy and paste using the system clipboard.
vim.keymap.set("v", "<leader>y", '"+y', noremap)
vim.keymap.set("v", "<leader>d", '"+d', noremap)
vim.keymap.set({ "n", "v" }, "<leader>p", '"+p', noremap)
vim.keymap.set({ "n", "v" }, "<leader>P", '"+P', noremap)

-- Selected the text that was just pasted.
vim.keymap.set("n", "gp", "`[v`]", noremap)
