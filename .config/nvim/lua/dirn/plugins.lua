local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "--branch=stable",
    lazyrepo,
    lazypath,
  })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

local plugins = {
  -- Colorscheme
  {
    "https://github.com/catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    setup = true,
    config = function()
      vim.opt.termguicolors = true

      vim.cmd.colorscheme("catppuccin")

      if vim.fn.has("mac") > 0 then
        vim.opt.background = "dark"
      else
        vim.opt.background = "light"
      end
    end,
  },

  -- LSP
  {
    {
      "https://github.com/williamboman/mason.nvim",
      dependencies = {
        "https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim",
      },
    },
    "https://github.com/lithammer/nvim-diagnosticls",
  },

  -- Treesitter
  {
    "https://github.com/nvim-treesitter/nvim-treesitter",
    dependencies = {
      "https://github.com/nvim-treesitter/nvim-treesitter-textobjects",
      "https://github.com/nvim-treesitter/playground",
    },
    build = ":TSUpdate",
    main = "nvim-treesitter.configs",
    opts = {
      ensure_installed = "all",
      highlight = {
        enable = true,
        custom_captures = { ["docstring"] = "TSString" },
      },
      indent = { enable = true },
      playground = {
        enable = true,
        disable = {},
        updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
        persist_queries = false, -- Whether the query persists across vim sessions
        keybindings = {
          toggle_query_editor = "o",
          toggle_hl_groups = "i",
          toggle_injected_languages = "t",
          toggle_anonymous_nodes = "a",
          toggle_language_display = "I",
          focus_language = "f",
          unfocus_language = "F",
          update = "R",
          goto_node = "<cr>",
          show_help = "?",
        },
      },
      textobjects = {
        select = {
          enable = true,
          keymaps = {
            ["af"] = "@function.outer",
            ["if"] = "@function.inner",
            ["ac"] = "@class.outer",
            ["ic"] = "@class.inner",
          },
        },
      },
    },
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
    "https://github.com/goolord/alpha-nvim",
    config = function()
      require("alpha").setup(require("dirn.dashboard").config)
    end,
  },

  {
    "https://github.com/hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "https://github.com/hrsh7th/cmp-buffer",
      "https://github.com/hrsh7th/cmp-calc",
      {
        "https://github.com/petertriho/cmp-git",
        opts = {
          filetypes = { "gitcommit" },
        },
      },
      "https://github.com/hrsh7th/cmp-nvim-lsp",
      "https://github.com/hrsh7th/cmp-nvim-lua",
      "https://github.com/hrsh7th/cmp-path",
      "https://github.com/nvim-lua/plenary.nvim",
    },
    config = function()
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
    end,
  },

  {
    "https://github.com/numToStr/Comment.nvim",
    keys = { { "gc", mode = { "n", "v" } } },
    config = true,
  },

  "https://github.com/rhysd/committia.vim",

  {
    "https://github.com/stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    opts = {
      format_on_save = { lsp_fallback = true, timeout_ms = 5000 },
      formatters = {
        ruff_fix = {
          -- Enable isort-like behavior.
          prepend_args = { "--extend-select=I" },
        },
      },
      formatters_by_ft = {
        fish = { "fish_indent" },
        lua = { "stylua" },
        -- Let ruff make any changes before Black formats the code.
        python = { "ruff_format", "black" },
        yaml = { "prettier" },
      },
    },
  },

  "https://github.com/rhysd/conflict-marker.vim",
  "https://github.com/blueyed/vim-diminactive",

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
    keys = {
      { "<c-p>", vim.cmd.GitFiles, noremap = true, silent = true },
      { "<leader>rg", vim.cmd.Rg, noremap = true, silent = true },
      { "<leader>ls", vim.cmd.Buffers, noremap = true, silent = true },
    },
    dependencies = { "https://github.com/junegunn/fzf" },
  },

  {
    "https://github.com/ruifm/gitlinker.nvim",
    dependencies = { "https://github.com/nvim-lua/plenary.nvim" },
    config = true,
  },

  {
    "https://github.com/lewis6991/gitsigns.nvim",
    dependencies = {
      "https://github.com/purarue/gitsigns-yadm.nvim",
      "https://github.com/nvim-lua/plenary.nvim",
    },
    cond = function()
      return os.getenv("NVIM_DISABLE_GITSIGNS") == nil
    end,
    opts = {
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
    },
  },

  {
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
  },

  {
    "https://github.com/tzachar/highlight-undo.nvim",
    opts = {
      keymaps = {
        paste = {
          disabled = true,
        },
        Paste = {
          disabled = true,
        },
      },
    },
  },

  "https://github.com/pbrisbin/vim-mkdir",

  {
    "https://github.com/nvim-neorg/neorg",
    version = "v7.0.0",
    build = ":Neorg sync-parsers",
    dependencies = {
      "https://github.com/nvim-lua/plenary.nvim",
    },
    opts = {
      load = {
        ["core.defaults"] = {},
        ["core.completion"] = { config = { engine = "nvim-cmp" } },
        ["core.concealer"] = {
          config = {
            icons = {
              todo = {
                cancelled = { icon = "_" },
                done = { icon = "x" },
                enabled = { icon = "e" },
                on_hold = { icon = "=" },
                pending = { icon = "-" },
                recurring = { icon = "+" },
                uncertain = { icon = "?" },
                undone = { icon = " " },
                urgent = { icon = "!" },
              },
            },
          },
        },
        ["core.dirman"] = {
          config = {
            workspaces = {
              home = "~/.local/share/nvim/neorg/home",
              work = "~/.local/share/nvim/neorg/work",
            },
          },
        },
      },
    },
  },

  {
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
  },

  {
    "https://github.com/folke/persistence.nvim",
    event = "BufReadPre",
    config = true,
    init = function()
      vim.api.nvim_create_autocmd("FileType", {
        group = vim.api.nvim_create_augroup("do-not-persist", { clear = true }),
        pattern = { "diff", "gitcommit", "gitrebase", "mail" },
        callback = function()
          require("persistence").stop()
        end,
      })
    end,
  },

  "https://github.com/raimon49/requirements.txt.vim",

  {
    "https://github.com/majutsushi/tagbar",
    cmd = { "Tagbar", "TagbarOpen", "TagbarToggle" },
  },

  {
    "https://github.com/nvim-telescope/telescope.nvim",
    dependencies = {
      "https://github.com/nvim-lua/popup.nvim",
      "https://github.com/nvim-lua/plenary.nvim",
    },
    keys = {
      {
        "<leader>bf",
        function()
          require("telescope.builtin").buffers()
        end,
        desc = "List the open buffers.",
        noremap = true,
        silent = true,
      },
      {
        "<leader>:",
        function()
          require("telescope.builtin").command_history()
        end,
        desc = "List command history.",
        noremap = true,
        silent = true,
      },
      {
        "<leader>?",
        function()
          require("telescope.builtin").help_tags()
        end,
        desc = "List available help tags.",
        noremap = true,
        silent = true,
      },
      {
        "<leader>km",
        function()
          require("telescope.builtin").keymaps()
        end,
        desc = "List normal mode keymappings.",
        noremap = true,
        silent = true,
      },
      {
        "<leader>cp",
        function()
          require("telescope.builtin").registers()
        end,
        desc = "List registers, pasting the contents on <cr>.",
        noremap = true,
        silent = true,
      },
      {
        "<leader>/",
        function()
          require("telescope.builtin").search_history()
        end,
        desc = "List recently executed searches.",
        noremap = true,
        silent = true,
      },
    },
    config = function()
      local actions = require("telescope.actions")

      require("telescope").setup({
        defaults = {
          mappings = {
            i = {
              ["<esc>"] = actions.close,
            },
          },
        },
      })
    end,
  },

  { "https://github.com/folke/todo-comments.nvim", config = true },
}
if vim.fn.executable("tmux") > 0 then
  table.insert(plugins, {
    "https://github.com/aserowy/tmux.nvim",
    opts = {
      navigation = {
        cycle_navigation = false,
        enable_default_keybindings = true,
        persist_zoom = true,
      },
    },
  })
end

local opts = {
  ui = {
    icons = {
      cmd = "⌘",
      config = "🛠",
      event = "📅",
      ft = "📂",
      init = "⚙",
      keys = "🗝",
      plugin = "🔌",
      runtime = "💻",
      source = "📄",
      start = "🚀",
      task = "📌",
      lazy = "💤 ",
    },
  },
}

require("lazy").setup(plugins, opts)
