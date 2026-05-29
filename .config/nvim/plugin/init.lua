vim.api.nvim_create_user_command("PackRestore", function()
  vim.pack.update(nil, { target = "lockfile", force = true })
end, {
  desc = "Restore the pack to the state of the lock file.",
})

vim.api.nvim_create_user_command("PackUpdate", function()
  vim.pack.update(nil, { force = true })
end, {
  desc = "Update the pack.",
})
