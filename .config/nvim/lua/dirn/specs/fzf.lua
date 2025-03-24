return {
  "https://github.com/junegunn/fzf.vim",
  keys = {
    { "<c-p>", vim.cmd.GitFiles, noremap = true, silent = true },
    { "<leader>rg", vim.cmd.Rg, noremap = true, silent = true },
    { "<leader>ls", vim.cmd.Buffers, noremap = true, silent = true },
  },
  dependencies = { "https://github.com/junegunn/fzf" },
}
