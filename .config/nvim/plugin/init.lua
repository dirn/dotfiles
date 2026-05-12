vim.api.nvim_create_user_command("PackClean", function()
  local inactive = vim
    .iter(vim.pack.get())
    :filter(function(plugin)
      return not plugin.active
    end)
    :map(function(plugin)
      return plugin.spec.name
    end)
    :totable()

  if #inactive > 0 then
    vim.pack.del(inactive)
  end
end, {
  desc = "Uninstall plugins not included in the pack.",
})

vim.api.nvim_create_user_command("PackRestore", function()
  vim.pack.update(nil, { target = "lockfile" })
end, {
  desc = "Restore the pack to the state of the lock file.",
})

vim.api.nvim_create_user_command("PackUpdate", function()
  vim.pack.update(nil, { force = true })
end, {
  desc = "Update the pack.",
})
