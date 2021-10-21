local fn = vim.fn

vim.g.gruvbox_material_background = "soft"

vim.opt.termguicolors = true

vim.cmd([[ colorscheme gruvbox-material ]])

if fn.has("mac") > 0 then
  vim.opt.background = "dark"
else
  vim.opt.background = "light"
end
