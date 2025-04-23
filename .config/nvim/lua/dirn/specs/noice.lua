-- Dependencies
-- nui.nvim

return {
  "https://github.com/folke/noice.nvim",
  event = "VeryLazy",
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
      lsp_doc_border = false,
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
