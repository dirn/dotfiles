-- Dependencies
-- plenary.nvim

return {
  "https://github.com/hrsh7th/nvim-cmp",
  event = "InsertEnter",
  dependencies = {
    "https://github.com/hrsh7th/cmp-buffer",
    "https://github.com/hrsh7th/cmp-calc",
    {
      "https://github.com/petertriho/cmp-git",
      opts = {
        filetypes = { "gitcommit" },
      },
    },
    "https://github.com/hrsh7th/cmp-nvim-lsp",
    "https://github.com/hrsh7th/cmp-nvim-lua",
    "https://github.com/hrsh7th/cmp-path",
  },
  config = function()
    local cmp = require("cmp")
    cmp.setup({
      formatting = {
        format = function(entry, vim_item)
          -- Show the source of the completion.
          vim_item.menu = ({
            buffer = "[Buffer]",
            calc = "[Calc]",
            cmp_git = "[Git]",
            nvim_lsp = "[LSP]",
            nvim_lua = "[Lua]",
            path = "[Path]",
          })[entry.source.name]
          return vim_item
        end,
      },
      mapping = cmp.mapping.preset.insert({
        ["<c-space>"] = cmp.mapping.complete(),
        ["<c-e>"] = cmp.mapping.close(),
        ["<cr>"] = cmp.mapping.confirm({
          behavior = cmp.ConfirmBehavior.Replace,
          select = true,
        }),
      }),
      sources = {
        { name = "nvim_lsp" },
        { name = "nvim_lua" },
        { name = "buffer" },
        { name = "git" },
        { name = "path" },
        { name = "calc" },
      },
    })
  end,
}
