local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "--branch=stable", -- remove this if you want to bootstrap to HEAD
    "https://github.com/folke/lazy.nvim.git",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

local plugins = {
  -- Colorscheme
  "https://github.com/Mofiqul/dracula.nvim",

  -- LSP
  {
    {
      "https://github.com/williamboman/mason.nvim",
      dependencies = {
        "https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim",
      },
    },
    "https://github.com/lithammer/nvim-diagnosticls",
    "https://github.com/tami5/lspsaga.nvim",
  },

  -- Treesitter
  {
    "https://github.com/nvim-treesitter/nvim-treesitter",
    dependencies = {
      "https://github.com/nvim-treesitter/nvim-treesitter-textobjects",
      "https://github.com/nvim-treesitter/playground",
    },
    build = ":TSUpdate",
  },

  -- Outside of the categories above, all plugins are listed here
  -- alphabetically. Upon first glance that may not appear to be the case, but
  -- the sort is a bit nuanced.
  --
  -- First, I'm sorting by the name of the plugin, not the repository owner. I
  -- do this because I can typically remember which plugins I'm using but not
  -- who maintains them.
  --
  -- Second, I'm ignoring the [n]vim- prefix in plugin names. I can't always
  -- remember which plugins use a prefix and which don't.
  --
  -- I realize that search makes all of this mostly unnecessary, but I try to
  -- keep things organized regardless.

  {
    "https://github.com/hrsh7th/nvim-cmp",
    dependencies = {
      "https://github.com/hrsh7th/cmp-buffer",
      "https://github.com/hrsh7th/cmp-calc",
      "https://github.com/petertriho/cmp-git",
      "https://github.com/hrsh7th/cmp-nvim-lsp",
      "https://github.com/hrsh7th/cmp-nvim-lua",
      "https://github.com/hrsh7th/cmp-path",
      "https://github.com/nvim-lua/plenary.nvim",
    },
  },

  {
    "https://github.com/numToStr/Comment.nvim",
    config = true,
  },

  "https://github.com/rhysd/committia.vim",

  "https://github.com/rhysd/conflict-marker.vim",

  "https://github.com/blueyed/vim-diminactive",

  "https://github.com/gpanders/editorconfig.nvim",

  {
    "https://github.com/tommcdo/vim-exchange",
    keys = { "cx" },
  },

  "https://github.com/wsdjeg/vim-fetch",

  {
    "https://github.com/beauwilliams/focus.nvim",
    config = true,
  },

  {
    "https://github.com/junegunn/fzf.vim",
    dependencies = { "https://github.com/junegunn/fzf" },
  },

  {
    "https://github.com/ruifm/gitlinker.nvim",
    dependencies = { "https://github.com/nvim-lua/plenary.nvim" },
    config = true,
  },

  {
    "https://github.com/lewis6991/gitsigns.nvim",
    dependencies = { "https://github.com/nvim-lua/plenary.nvim" },
  },

  {
    "https://github.com/ThePrimeagen/harpoon",
    dependencies = {
      "https://github.com/nvim-lua/plenary.nvim",
      "https://github.com/nvim-lua/popup.nvim",
    },
  },

  "https://github.com/ggandor/leap.nvim",

  "https://github.com/pbrisbin/vim-mkdir",

  "https://github.com/folke/persistence.nvim",

  "https://github.com/raimon49/requirements.txt.vim",

  "https://github.com/majutsushi/tagbar",

  {
    "https://github.com/nvim-telescope/telescope.nvim",
    dependencies = {
      { "https://github.com/nvim-lua/popup.nvim" },
      { "https://github.com/nvim-lua/plenary.nvim" },
    },
  },

  "https://github.com/folke/todo-comments.nvim",
}
if vim.fn.executable("tmux") > 0 then
  table.insert(plugins, "https://github.com/aserowy/tmux.nvim")
end

local options = {
  git = {
    -- This allows me to specify the full URL for all of my plugins without
    -- having to use a table with a url field for each one.
    url_format = "%s.git",
  },
}

require("lazy").setup(plugins, options)
