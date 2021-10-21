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
    -- "https://github.com/ishan9299/nvim-solarized-lua",
    "https://github.com/sainnhe/gruvbox-material",
    config = [[ require('config.colorscheme') ]],
  })

  -- LSP
  use({
    "https://github.com/neovim/nvim-lspconfig",
    {
      "https://github.com/tami5/lspsaga.nvim",
      -- master has dropped support for Neovim 0.5 in preparation of the release
      -- of 0.6. Until 0.6 has a stable release, pin the version to one that's
      -- compatible with 0.5.
      branch = "nvim51",
      config = [[ require('config.lspsaga') ]],
    },
    {
      "https://github.com/kabouzeid/nvim-lspinstall",
      config = [[ require('config.lspinstall') ]],
    },
  })

  -- Treesitter
  use({
    "https://github.com/nvim-treesitter/nvim-treesitter",
    requires = {
      "https://github.com/nvim-treesitter/nvim-treesitter-textobjects",
      "https://github.com/nvim-treesitter/playground",
    },
    branch = "0.5-compat",
    run = ":TSUpdate",
    config = [[ require('config.treesitter') ]],
  })

  use({
    "https://github.com/hrsh7th/nvim-cmp",
    requires = {
      "https://github.com/hrsh7th/cmp-buffer",
      "https://github.com/hrsh7th/cmp-calc",
      "https://github.com/hrsh7th/cmp-nvim-lsp",
      "https://github.com/hrsh7th/cmp-nvim-lua",
      "https://github.com/hrsh7th/cmp-path",
    },
    config = [[ require('config.completion') ]],
  })

  use("https://github.com/rhysd/committia.vim")

  use("https://github.com/rhysd/conflict-marker.vim")

  use("https://github.com/editorconfig/editorconfig-vim")

  use({
    "https://github.com/junegunn/fzf.vim",
    requires = { "https://github.com/junegunn/fzf" },
    config = [[ require('config.fzf') ]],
  })

  use({
    "https://github.com/ruifm/gitlinker.nvim",
    requires = { "https://github.com/nvim-lua/plenary.nvim" },
    config = [[ require('gitlinker').setup() ]],
  })

  use({
    "https://github.com/lewis6991/gitsigns.nvim",
    requires = { "https://github.com/nvim-lua/plenary.nvim" },
    config = [[ require('config.gitsigns') ]],
  })

  use({
    "https://github.com/ThePrimeagen/harpoon",
    requires = {
      "https://github.com/nvim-lua/plenary.nvim",
      "https://github.com/nvim-lua/popup.nvim",
    },
    config = [[ require('config.harpoon') ]],
  })

  use({
    "https://github.com/camspiers/lens.vim",
    requires = { "https://github.com/camspiers/animate.vim" },
    config = [[ require('config.lens') ]],
  })

  use("https://github.com/pbrisbin/vim-mkdir")

  use("https://github.com/raimon49/requirements.txt.vim")

  use("https://github.com/majutsushi/tagbar")

  use({
    "https://github.com/nvim-telescope/telescope.nvim",
    requires = {
      { "nvim-lua/popup.nvim" },
      { "nvim-lua/plenary.nvim" },
    },
    config = [[ require('config.telescope') ]],
  })

  use("https://gitlab.com/dirn/TODO.vim")

  use("https://github.com/tpope/vim-commentary")

  use("https://github.com/blueyed/vim-diminactive")

  use("https://github.com/tommcdo/vim-exchange")

  use("https://github.com/wsdjeg/vim-fetch")

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

  -- use 'https://github.com/Vimjas/vim-python-pep8-indent'

  if fn.executable("tmux") > 0 then
    use({
      "https://github.com/aserowy/tmux.nvim",
      config = [[ require('config.tmux') ]],
    })
  end
end)
