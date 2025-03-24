return {
  "https://github.com/aserowy/tmux.nvim",
  cond = function()
    return vim.fn.executable("tmux") > 0
  end,
  opts = {
    navigation = {
      cycle_navigation = false,
      enable_default_keybindings = true,
      persist_zoom = true,
    },
  },
}
