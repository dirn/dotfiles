local has_mason, mason = pcall(require, "mason")
if not has_mason then
  return
end

local has_installer, installer = pcall(require, "mason-tool-installer")
if not has_installer then
  return
end

local server_path = require("mason-core.path").bin_prefix

mason.setup()
installer.setup({
  ensure_installed = {
    "black",
    "diagnostic-languageserver",
    "jedi-language-server",
    "lua-language-server",
    "mypy",
    "prettier",
    "ruff-lsp",
    "rust-analyzer",
    "stylua",
    "yamllint",
  },
})

local find_root_dir = function(files)
  return vim.fs.dirname(vim.fs.find(files, { upward = true })[1])
end

local configs = {
  jedi_language_server = {
    name = "jedi_language_server",
    cmd = { server_path("jedi-language-server") },
    filetypes = { "python" },
    root_dir = find_root_dir({
      "pyproject.toml",
      "requirements.txt",
      "setup.cfg",
      "setup.py",
    }),
    single_file_support = true,
  },
  ruff_lsp = {
    name = "ruff_lsp",
    cmd = { server_path("ruff-lsp") },
    filetypes = { "python" },
    root_dir = find_root_dir({
      "pyproject.toml",
      "requirements.txt",
      "setup.cfg",
      "setup.py",
    }),
    single_file_support = true,
    init_options = {
      settings = {
        -- Enable isort-like behavior.
        args = { "--extend-select=I" },
      },
    },
  },
  rust_analyzer = {
    name = "rust_analyzer",
    cmd = { server_path("rust-analyzer") },
    filetypes = { "rust" },
    root_dir = find_root_dir({ "Cargo.toml" }),
  },
  sumneko_lua = {
    name = "sumneko_lua",
    cmd = { server_path("lua-language-server") },
    filetypes = { "lua" },
    root_dir = find_root_dir({ "stylua.toml" }),
    single_file_support = true,
    settings = {
      Lua = {
        diagnostics = {
          disable = { "lowercase-global" },
          globals = { "vim" },
        },
        runtime = {
          version = "LuaJIT",
        },
        telemetry = {
          enable = false,
        },
        workspace = {
          library = vim.api.nvim_get_runtime_file("", true),
        },
      },
    },
  },
}

local has_diagnosticls, diagnosticls = pcall(require, "diagnosticls")
if has_diagnosticls then
  configs["diagnosticls"] = {
    name = "diagnosticls",
    cmd = { server_path("diagnostic-languageserver"), "--stdio" },
    filetypes = { "fish", "lua", "python", "yaml" },
    root_dir = find_root_dir({ ".editorconfig", "stylua.toml", ".git" }),
    single_file_support = true,
    init_options = {
      linters = diagnosticls.linters,
      formatters = diagnosticls.formatters,
      filetypes = {
        fish = { "fish" },
        python = { "mypy" },
        yaml = { "yamllint" },
      },
      formatFiletypes = {
        fish = { "fish_indent" },
        lua = { "stylua" },
        python = { "black" },
        yaml = { "prettier" },
      },
    },
  }
end

local has_local_lsp, local_lsp = pcall(require, "dirn.lspextras")
if has_local_lsp then
  configs = local_lsp.merge(configs)
end

lsp_augroup = vim.api.nvim_create_augroup("lsp", {})
for server, config in pairs(configs) do
  vim.api.nvim_create_autocmd("FileType", {
    desc = "Associate the " .. server .. " client with its file types.",
    group = lsp_augroup,
    pattern = config.filetypes,
    callback = function()
      vim.lsp.start(config, {
        reuse_client = function(client, conf)
          return client.name == conf.name
            and client.config.root_dir == conf.root_dir
        end,
      })
    end,
  })
end

vim.api.nvim_create_autocmd("LspAttach", {
  desc = "Configure the buffer's capabilities.",
  callback = function(args)
    -- Navigate diagnostics.
    vim.keymap.set("n", "[a", function()
      vim.diagnostic.goto_prev({ float = true, wrap = false })
    end, {
      desc = "Go to the previous diagnostics.",
      buffer = args.buf,
      noremap = true,
      silent = true,
    })
    vim.keymap.set("n", "]a", function()
      vim.diagnostic.goto_next({ float = true, wrap = false })
    end, {
      desc = "Go to the next diagnostics.",
      buffer = args.buf,
      noremap = true,
      silent = true,
    })
    vim.keymap.set("n", "<leader>a", vim.diagnostic.open_float, {
      desc = "Show active diagnostics for the position under the cursor.",
      buffer = args.buf,
      noremap = true,
      silent = true,
    })

    local client = vim.lsp.get_client_by_id(args.data.client_id)

    -- Navigate code.
    if client.server_capabilities.definitionProvider then
      vim.keymap.set("n", "gy", function()
        local ok, telescope = pcall(require, "telescope.builtin")
        if ok then
          telescope.lsp_type_definitions()
        else
          vim.lsp.buf.type_definition()
        end
      end, {
        desc = "Go to the definition of the type under the cursor.",
        buffer = args.buf,
        noremap = true,
        silent = true,
      })
      vim.keymap.set("n", "gr", function()
        local ok, telescope = pcall(require, "telescope.builtin")
        if ok then
          telescope.lsp_references()
        else
          vim.lsp.buf.references()
        end
      end, {
        desc = "Show references to the identifier under the cursor.",
        buffer = args.buf,
        noremap = true,
        silent = true,
      })
    end

    -- Show documentation.
    vim.keymap.set("n", "K", vim.lsp.buf.hover, {
      desc = "Show documentation for the identifier under the cursor.",
      buffer = args.buf,
      noremap = true,
      silent = true,
    })

    -- Refactor code.
    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, {
      desc = "Rename the identifier under the cursor.",
      buffer = args.buf,
      noremap = true,
      silent = true,
    })
    vim.keymap.set("n", "<leader>fx", vim.lsp.buf.code_action, {
      desc = "Apply code actions.",
      buffer = args.buf,
      noremap = true,
      silent = true,
    })

    if client.server_capabilities.documentFormattingProvider then
      vim.api.nvim_create_autocmd("BufWritePre", {
        desc = "Format the buffer when saving it.",
        group = vim.api.nvim_create_augroup("format-on-save", {}),
        pattern = "<buffer>",
        callback = function()
          vim.lsp.buf.format({ timeout_ms = 5000 })
        end,
      })
    end

    vim.api.nvim_create_autocmd("CursorHold", {
      desc = "Show active diagnostics for the position under the cursor.",
      group = vim.api.nvim_create_augroup("show-diagnostics", { clear = true }),
      pattern = "<buffer>",
      callback = vim.diagnostic.open_float,
    })
  end,
})

vim.diagnostic.config({
  float = {
    border = "single",
    focusable = false,
    scope = "cursor",
    separator = true,
  },
})

local signs = { Error = ">>", Warn = "--", Hint = "--", Info = "--" }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end

vim.lsp.handlers["textDocument/publishDiagnostics"] =
  vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
    -- Disable virtual text globally.
    virtual_text = false,
  })
