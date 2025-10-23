-- Long comments and strings should only be 72 characters, not 79.
vim.opt_local.colorcolumn = { 73, 80, 100 }
-- Let Black worry about where to break the lines.
vim.opt_local.textwidth = 99

vim.cmd.iabbrev(
  "<buffer>",
  "ifmain",
  'if __name__ == "__main__":<cr>main()<c-o>v^<c-g>'
)

vim.api.nvim_create_autocmd("BufWritePre", {
  group = vim.api.nvim_create_augroup(
    "format-python-on-save",
    { clear = true }
  ),
  pattern = { "<buffer>" },
  callback = function()
    vim.lsp.buf.code_action({
      context = {
        only = { "source.fixAll.ruff" },
      },
      apply = true,
    })
    vim.lsp.buf.format({ async = true })
    vim.lsp.buf.code_action({
      context = {
        only = { "source.organizeImports.ruff" },
      },
      apply = true,
    })
  end,
})
