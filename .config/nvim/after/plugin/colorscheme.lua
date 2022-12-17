vim.g.dracula_show_end_of_buffer = true
vim.g.dracula_transparent_bg = false

vim.opt.termguicolors = true

vim.cmd.colorscheme("dracula")

if vim.fn.has("mac") > 0 then
  vim.opt.background = "dark"
else
  vim.opt.background = "light"
end
