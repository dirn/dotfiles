return {
  "https://github.com/folke/noice.nvim",
  event = "VeryLazy",
  dependencies = {
    "https://github.com/MunifTanjim/nui.nvim",
    {
      "https://github.com/rcarriga/nvim-notify",
      config = function()
        vim.keymap.set("n", "<leader><leader>", function()
          require("notify").dismiss({ silent = true, pending = true })
        end, {
          desc = "Dismiss all notifications",
          noremap = true,
          silent = true,
        })
      end,
    },
  },
  opts = {
    cmdline = {
      format = {
        cmdline = { icon = ":" },
        help = { icon = ":h" },
        filter = { icon = "!" },
        lua = { icon = ">" },
        search_down = { icon = "/" },
        search_up = { icon = "?" },
      },
    },
    format = {
      level = {
        icons = {
          error = "X",
          warn = "!",
          info = " ",
        },
      },
    },
    lsp = {
      override = {
        ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
        ["vim.lsp.util.stylize_markdown"] = true,
        ["cmp.entry.get_documentation"] = true,
      },
      signature = { auto_open = { enabled = false } },
    },
    messages = { view_search = false },
    popupmenu = { kind_icons = false },
    presets = {
      command_palette = true,
      lsp_doc_border = true,
    },
    routes = {
      filter = {
        event = "msg_show",
        kind = "search_count",
      },
      opts = { skip = true },
    },
  },
}
