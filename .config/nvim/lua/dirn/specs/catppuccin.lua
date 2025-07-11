return {
  "https://github.com/catppuccin/nvim",
  name = "catppuccin",
  lazy = false,
  priority = 1000,
  opts = {
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
  },
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
