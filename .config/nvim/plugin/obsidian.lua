load_on("UIEnter", function()
  vim.schedule(function()
    vim.pack.add({
      "https://github.com/obsidian-nvim/obsidian.nvim",
    })

    require("obsidian").setup({
      daily_notes = {
        folder = "daily",
        workdays_only = false,
      },
      footer = {
        enabled = false,
      },
      legacy_commands = false,
      link = {
        style = "markdown",
      },
      note_id_func = require("obsidian.builtin").title_id,
      picker = {
        name = "snacks",
      },
      workspaces = {
        {
          name = "home",
          path = "~/.local/share/nvim/obsidian/home",
        },
        {
          name = "work",
          path = "~/.local/share/nvim/obsidian/work",
        },
      },
    })
  end)

  -- Hide text and show symbols and labels for Obsidian files.
  vim.api.nvim_create_autocmd("FileType", {
    pattern = "markdown",
    callback = function(args)
      local path = vim.api.nvim_buf_get_name(args.buf):lower()
      if not path:find("obsidian", 1, true) then
        return
      end

      local win = vim.fn.bufwinid(args.buf)
      if win ~= -1 then
        vim.wo[win].conceallevel = 2
      end
    end,
  })
end)
