local fn = vim.fn

local autocmd = require("config").autocmd

-- Install packer and any missing plugins if they haven't already been
-- installed.
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  vim.api.nvim_command(
    "!git clone https://github.com/wbthomason/packer.nvim " .. install_path
  )
end
vim.cmd([[ packadd packer.nvim ]])

-- Auto compile the pack when there are changes to the plugins file.
autocmd("packer", "BufWritePost plugins.lua PackerCompile")

return require("packer").startup(function(use)
  -- Let packer manage itself.
  use("https://github.com/wbthomason/packer.nvim")

  -- Colorscheme
  use({
    "https://github.com/sainnhe/gruvbox-material",
    config = function()
      require("config.colorscheme")
    end,
  })

  -- LSP
  use({
    "https://github.com/neovim/nvim-lspconfig",
    {
      "https://github.com/tami5/lspsaga.nvim",
      -- master has dropped support for Neovim 0.5 in preparation of the release
      -- of 0.6. Until 0.6 has a stable release, pin the version to one that's
      -- compatible with 0.5.
      -- TODO: Remove this once 0.6 has been released.
      branch = "nvim51",
      config = function()
        require("config.lspsaga")
      end,
    },
    "https://github.com/williamboman/nvim-lsp-installer",
  })

  -- Treesitter
  use({
    "https://github.com/nvim-treesitter/nvim-treesitter",
    requires = {
      "https://github.com/nvim-treesitter/nvim-treesitter-textobjects",
      "https://github.com/nvim-treesitter/playground",
    },
    -- TODO: Remove this once 0.6 has been released.
    branch = "0.5-compat",
    run = ":TSUpdate",
    config = function()
      require("config.treesitter")
    end,
  })

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

  use({
    "https://github.com/hrsh7th/nvim-cmp",
    requires = {
      "https://github.com/hrsh7th/cmp-buffer",
      "https://github.com/hrsh7th/cmp-calc",
      "https://github.com/petertriho/cmp-git",
      "https://github.com/hrsh7th/cmp-nvim-lsp",
      "https://github.com/hrsh7th/cmp-nvim-lua",
      "https://github.com/hrsh7th/cmp-path",
      "https://github.com/nvim-lua/plenary.nvim",
    },
    config = function()
      require("config.completion")
    end,
  })

  use({
    "https://github.com/numToStr/Comment.nvim",
    config = function()
      require("Comment").setup()
    end,
  })

  use("https://github.com/rhysd/committia.vim")

  use("https://github.com/rhysd/conflict-marker.vim")

  use("https://github.com/blueyed/vim-diminactive")

  use("https://github.com/editorconfig/editorconfig-vim")

  use("https://github.com/tommcdo/vim-exchange")

  use("https://github.com/wsdjeg/vim-fetch")

  use({
    "https://github.com/junegunn/fzf.vim",
    requires = { "https://github.com/junegunn/fzf" },
    config = function()
      require("config.fzf")
    end,
  })

  use({
    "https://github.com/ruifm/gitlinker.nvim",
    requires = { "https://github.com/nvim-lua/plenary.nvim" },
    config = function()
      require("gitlinker").setup()
    end,
  })

  use({
    "https://github.com/lewis6991/gitsigns.nvim",
    requires = { "https://github.com/nvim-lua/plenary.nvim" },
    config = function()
      require("config.gitsigns")
    end,
  })

  use({
    "https://github.com/ThePrimeagen/harpoon",
    requires = {
      "https://github.com/nvim-lua/plenary.nvim",
      "https://github.com/nvim-lua/popup.nvim",
    },
    config = function()
      require("config.harpoon")
    end,
  })

  use({
    "https://github.com/camspiers/lens.vim",
    requires = { "https://github.com/camspiers/animate.vim" },
    config = function()
      require("config.lens")
    end,
  })

  use("https://github.com/pbrisbin/vim-mkdir")

  use({
    "https://github.com/inkarkat/vim-OnSyntaxChange",
    requires = {
      { "https://github.com/inkarkat/vim-ingo-library", branch = "stable" },
    },
    branch = "stable",
    ft = { "python" },
  })

  use({
    "https://github.com/dhruvasagar/vim-prosession",
    requires = { "https://github.com/tpope/vim-obsession" },
  })

  use("https://github.com/raimon49/requirements.txt.vim")

  use("https://github.com/majutsushi/tagbar")

  use({
    "https://github.com/nvim-telescope/telescope.nvim",
    requires = {
      { "nvim-lua/popup.nvim" },
      { "nvim-lua/plenary.nvim" },
    },
    config = function()
      require("config.telescope")
    end,
  })

  if fn.executable("tmux") > 0 then
    use({
      "https://github.com/aserowy/tmux.nvim",
      config = function()
        require("config.tmux")
      end,
    })
  end

  use("https://gitlab.com/dirn/TODO.vim")
end)
