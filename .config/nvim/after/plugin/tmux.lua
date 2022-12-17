local ok, tmux = pcall(require, "tmux")
if not ok then
  return
end

tmux.setup({
  navigation = {
    cycle_navigation = false,
    enable_default_keybindings = true,
    persist_zoom = true,
  },
})
