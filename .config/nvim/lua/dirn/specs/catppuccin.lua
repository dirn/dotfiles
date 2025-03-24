return {
  "https://github.com/catppuccin/nvim",
  name = "catppuccin",
  priority = 1000,
  setup = true,
  config = function()
    vim.opt.termguicolors = true

    vim.cmd.colorscheme("catppuccin")

    if vim.fn.has("mac") > 0 then
      vim.opt.background = "dark"
    else
      vim.opt.background = "light"
    end
  end,
}
