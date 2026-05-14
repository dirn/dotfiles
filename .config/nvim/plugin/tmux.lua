local function has_tmux()
  return vim.fn.executable("tmux") > 0
end

if has_tmux() then
  load_on("UIEnter", function()
    vim.schedule(function()
      vim.pack.add({
        "https://github.com/aserowy/tmux.nvim",
      })

      -- TODO: Can I remove this redundancy? Is there an autocmd (e.g., PackChanged) that I
      -- can listen for to call setup?
      require("tmux").setup({
        navigation = {
          cycle_navigation = false,
          enable_default_keybindings = true,
          persist_zoom = true,
        },
      })
    end)
  end)
end
