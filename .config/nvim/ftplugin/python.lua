-- Long comments and strings should only be 72 characters, not 79.
vim.opt_local.colorcolumn = { 73, 80, 100 }
-- Let Black worry about where to break the lines.
vim.opt_local.textwidth = 99

vim.cmd.iabbrev(
  "<buffer>",
  "ifmain",
  'if __name__ == "__main__":<cr>main()<c-o>v^<c-g>'
)
