vim.pack.add({
  "https://github.com/catppuccin/nvim",
})

require("catppuccin").setup({
  integrations = {
    alpha = true,
    cmp = true,
    copilot = true,
    gitsigns = true,
    mason = true,
    noice = true,
    notify = true,
    snacks = { enabled = true },
    treesitter = true,
  },
})

vim.opt.termguicolors = true

vim.cmd.colorscheme("catppuccin")

if vim.fn.has("mac") > 0 then
  vim.opt.background = "dark"
else
  vim.opt.background = "light"
end
