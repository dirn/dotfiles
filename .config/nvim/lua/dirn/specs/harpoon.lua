return {
  "https://github.com/ThePrimeagen/harpoon",
  keys = {
    {
      "<leader>ha",
      function()
        require("harpoon.mark").add_file()
      end,
      noremap = true,
      silent = true,
    },
    {
      "<leader>hn",
      function()
        require("harpoon.ui").nav_next()
      end,
      noremap = true,
      silent = true,
    },
    {
      "<leader>hp",
      function()
        require("harpoon.ui").nav_prev()
      end,
      noremap = true,
      silent = true,
    },
    {
      "<leader>ht",
      function()
        local ok, telescope = pcall(require, "telescope")
        if ok then
          telescope.extensions.harpoon.marks()
        else
          require("harpoon.ui").toggle_quick_menu()
        end
      end,
      noremap = true,
      silent = true,
    },
  },
  dependencies = {
    "https://github.com/nvim-lua/plenary.nvim",
    "https://github.com/nvim-lua/popup.nvim",
  },
  config = function()
    local ok, telescope = pcall(require, "telescope")
    if ok then
      telescope.load_extension("harpoon")
    end

    require("harpoon").setup()
  end,
}
