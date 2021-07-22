local fn = vim.fn

vim.g.solarized_italics = false

vim.opt.termguicolors = true
vim.cmd([[ colorscheme solarized-flat ]])
-- vim.cmd [[ colorscheme solarized8 ]]
if fn.has("mac") > 0 then
  vim.opt.background = "dark"
else
  vim.opt.background = "light"
end
