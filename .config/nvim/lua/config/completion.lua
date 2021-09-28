local cmp = require("cmp")

cmp.setup({
  formatting = {
    format = function(entry, vim_item)
      -- Show the source of the completion.
      vim_item.menu = ({
        buffer = "[Buffer]",
        calc = "[Calc]",
        nvim_lsp = "[LSP]",
        nvim_lua = "[Lua]",
        path = "[Path]",
      })[entry.source.name]
      return vim_item
    end,
  },
  mapping = {
    ["<c-space>"] = cmp.mapping.complete(),
    ["<c-e>"] = cmp.mapping.close(),
    ["<cr>"] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    }),
  },
  sources = {
    { name = "buffer" },
    { name = "calc" },
    { name = "nvim_lsp" },
    { name = "nvim_lua" },
    { name = "path" },
  },
})
