vim.schedule(function()
  vim.pack.add({
    "https://github.com/hrsh7th/nvim-cmp",

    "https://github.com/hrsh7th/cmp-buffer",
    "https://github.com/hrsh7th/cmp-calc",

    "https://github.com/nvim-lua/plenary.nvim",
    "https://github.com/petertriho/cmp-git",

    "https://github.com/neovim/nvim-lspconfig",
    "https://github.com/hrsh7th/cmp-nvim-lsp",

    "https://github.com/hrsh7th/cmp-nvim-lua",
    "https://github.com/hrsh7th/cmp-path",
  })

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

  cmp.setup.filetype("gitcommit", {
    sources = cmp.config.sources({
      { name = "git" },
    }, {
      { name = "buffer" },
    }),
  })
  require("cmp_git").setup()
end)
