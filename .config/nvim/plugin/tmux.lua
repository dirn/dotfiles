local function has_tmux()
  return vim.fn.executable("tmux") > 0
end

vim.pack.add({
  "https://github.com/aserowy/tmux.nvim",
}, {
  load = has_tmux(),
})

-- TODO: Can I remove this redundancy? Is there an autocmd (e.g., PackChanged) that I
-- can listen for to call setup?
if has_tmux() then
  require("tmux").setup({
    navigation = {
      cycle_navigation = false,
      enable_default_keybindings = true,
      persist_zoom = true,
    },
  })
end
