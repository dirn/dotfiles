vim.keymap.set("i", "jk", "<esc>")

vim.keymap.set("n", "<leader>Q", "<cmd>%bdelete<cr>")

-- The following set of previous/next/first/last mappings are inspired by
-- (borrowed from) https://github.com/tpope/vim-unimpaired.
-- Navigate buffers.
vim.keymap.set(
  "n",
  "[b",
  vim.cmd.bprevious,
  { desc = "Go to the previous buffer.", noremap = true, silent = true }
)
vim.keymap.set(
  "n",
  "]b",
  vim.cmd.bnext,
  { desc = "Go to the next buffer.", noremap = true, silent = true }
)
vim.keymap.set(
  "n",
  "[B",
  vim.cmd.bfirst,
  { desc = "Go to the first buffer.", noremap = true, silent = true }
)
vim.keymap.set(
  "n",
  "]B",
  vim.cmd.blast,
  { desc = "Go to the last buffer.", noremap = true, silent = true }
)

-- Navigate the location list.
vim.keymap.set(
  "n",
  "[l",
  vim.cmd.lprevious,
  { desc = "Go to the previous location.", noremap = true, silent = true }
)
vim.keymap.set(
  "n",
  "]l",
  vim.cmd.lnext,
  { desc = "Go to the next location.", noremap = true, silent = true }
)
vim.keymap.set(
  "n",
  "[L",
  vim.cmd.lfirst,
  { desc = "Go to the first location.", noremap = true, silent = true }
)
vim.keymap.set(
  "n",
  "]L",
  vim.cmd.llast,
  { desc = "Go to the last location.", noremap = true, silent = true }
)

-- Navigate the quickfix list.
vim.keymap.set(
  "n",
  "[q",
  vim.cmd.qprevious,
  { desc = "Go to the previous error.", noremap = true, silent = true }
)
vim.keymap.set(
  "n",
  "]q",
  vim.cmd.qnext,
  { desc = "Go to the next error.", noremap = true, silent = true }
)
vim.keymap.set(
  "n",
  "[Q",
  vim.cmd.qfirst,
  { desc = "Go to the first error.", noremap = true, silent = true }
)
vim.keymap.set(
  "n",
  "]Q",
  vim.cmd.qlast,
  { desc = "Go to the last error.", noremap = true, silent = true }
)

-- Navigate tabs (these differ from vim-unimpaired).
vim.keymap.set(
  "n",
  "[t",
  vim.cmd.tprevious,
  { desc = "Go to the previous tab.", noremap = true, silent = true }
)
vim.keymap.set(
  "n",
  "]t",
  vim.cmd.tnext,
  { desc = "Go to the next tab.", noremap = true, silent = true }
)
vim.keymap.set(
  "n",
  "[T",
  vim.cmd.tfirst,
  { desc = "Go to the first tab.", noremap = true, silent = true }
)
vim.keymap.set(
  "n",
  "]T",
  vim.cmd.tlast,
  { desc = "Go to the last tab.", noremap = true, silent = true }
)

-- Copy and paste using the system clipboard.
vim.keymap.set(
  "v",
  "<leader>y",
  '"+y',
  { desc = "Yank to the system clipboard.", noremap = true, silent = true }
)
vim.keymap.set(
  "v",
  "<leader>d",
  '"+d',
  { desc = "Delete to the system clipboard.", noremap = true, silent = true }
)
vim.keymap.set({ "n", "v" }, "<leader>p", '"+p', {
  desc = "Paste from the system clipboard after the after.",
  noremap = true,
  silent = true,
})
vim.keymap.set({ "n", "v" }, "<leader>P", '"+P', {
  desc = "Paste from the system clipboard before the cursor.",
  noremap = true,
  silent = true,
})

-- Selected the text that was just pasted.
vim.keymap.set(
  "n",
  "gp",
  "`[v`]",
  { desc = "Select the text that was pasted.", noremap = true, silent = true }
)
