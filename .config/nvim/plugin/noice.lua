load_on("UIEnter", function()
  -- NOTE: vim.schedule is used to delay loading noice slightly so that prompts from
  -- loading plugins don't get swallowed.
  vim.schedule(function()
    vim.pack.add({
      "https://github.com/MunifTanjim/nui.nvim",
      "https://github.com/folke/noice.nvim",
    })

    require("noice").setup({
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
        hover = { enabled = false },
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = false,
          ["vim.lsp.util.stylize_markdown"] = false,
          ["cmp.entry.get_documentation"] = false,
        },
        signature = { enabled = false },
      },
      messages = {
        view_search = "mini",
      },
      popupmenu = { enabled = true, kind_icons = false },
      presets = {
        command_palette = true,
      },
      routes = {
        -- Show @recording messages in the cmdline.
        {
          filter = { event = "msg_showmode" },
          view = "cmdline",
        },
      },
    })
  end)
end)
