local function gitsigns_enabled()
  return os.getenv("NVIM_DISABLE_GITSIGNS") == nil
end

if gitsigns_enabled() then
  load_on({ "BufReadPost", "BufNewFile" }, function()
    vim.pack.add({
      "https://github.com/lewis6991/gitsigns.nvim",
      "https://github.com/purarue/gitsigns-yadm.nvim",
    })

    require("gitsigns").setup({
      _on_attach_pre = function(bufnr, callback)
        require("gitsigns-yadm").yadm_signs(callback, { bufnr = bufnr })
      end,
      signs = {
        add = {
          text = "+",
        },
        change = {
          text = "~",
        },
        delete = {
          text = "_",
        },
        topdelete = {
          text = "‾",
        },
        changedelete = {
          text = "~_",
        },
      },
    })
  end)
end
