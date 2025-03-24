if vim.fn.executable("tmux") > 0 then
  return {
    "https://github.com/aserowy/tmux.nvim",
    opts = {
      navigation = {
        cycle_navigation = false,
        enable_default_keybindings = true,
        persist_zoom = true,
      },
    },
  }
else
  return {}
end
