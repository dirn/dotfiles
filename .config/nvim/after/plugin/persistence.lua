local ok, persistence = pcall(require, "persistence")
if not ok then
  return
end

persistence.setup()

vim.api.nvim_create_autocmd("VimEnter", {
  group = vim.api.nvim_create_augroup("persistence", { clear = true }),
  callback = function()
    require("persistence").load()
  end,
})
