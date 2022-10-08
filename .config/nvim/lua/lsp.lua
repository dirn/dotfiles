local find_root_dir = function(files)
  return vim.fs.dirname(vim.fs.find(files, { upward = true })[1])
end

local server_path = function(server)
  -- Right now this configuration relies on nvim-lsp-installer to install the
  -- language servers. I've decided to encapsulate the path for the binaries in
  -- here because I'm exploring alternative approaches and that will make it
  -- easier to try them out.
  local path = vim.fn.stdpath("data") .. "/lsp_servers/"
  if server == "diagnosticls" then
    path = path .. "diagnosticls/node_modules/.bin/diagnostic-languageserver"
  elseif server == "jedi_language_server" then
    path = path .. "jedi_language_server/venv/bin/jedi-language-server"
  elseif server == "rust_analyzer" then
    path = path .. "rust/rust-analyzer"
  elseif server == "sumneko_lua" then
    path = path .. "sumneko_lua/extension/server/bin/lua-language-server"
  end
  return path
end

local configs = {
  jedi_language_server = {
    name = "jedi_language_server",
    cmd = { server_path("jedi_language_server") },
    filetypes = { "python" },
    root_dir = find_root_dir({
      "pyproject.toml",
      "requirements.txt",
      "setup.cfg",
      "setup.py",
    }),
    single_file_support = true,
  },
  rust_analyzer = {
    name = "rust_analyzer",
    cmd = { server_path("rust_analyzer") },
    filetypes = { "rust" },
    root_dir = find_root_dir({ "Cargo.toml" }),
  },
  sumneko_lua = {
    name = "sumneko_lua",
    cmd = { server_path("sumneko_lua") },
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
    cmd = { server_path("diagnosticls"), "--stdio" },
    filetypes = { "fish", "lua", "python", "yaml" },
    root_dir = find_root_dir({ ".editorconfig", "stylua.toml", ".git" }),
    single_file_support = true,
    init_options = {
      linters = diagnosticls.linters,
      formatters = diagnosticls.formatters,
      filetypes = {
        fish = { "fish" },
        python = { "flake8", "mypy" },
        yaml = { "yamllint" },
      },
      formatFiletypes = {
        fish = { "fish_indent" },
        lua = { "stylua" },
        python = { "black", "isort" },
      },
    },
  }
end

local has_local_lsp, local_lsp = pcall(require, "lspextras")
if has_local_lsp then
  configs = local_lsp.merge(configs)
end

for _, config in pairs(configs) do
  vim.api.nvim_create_autocmd("FileType", {
    group = vim.api.nvim_create_augroup("lsp", {}),
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
  callback = function(args)
    local opts = { buffer = args.buf, noremap = true, silent = true }

    -- Navigate diagnostics.
    vim.keymap.set("n", "[a", function()
      require("lspsaga.diagnostic").navigate("prev")({ wrap = false })
    end, opts)
    vim.keymap.set("n", "]a", function()
      require("lspsaga.diagnostic").navigate("next")({ wrap = false })
    end, opts)
    vim.keymap.set("n", "<leader>a", function()
      require("lspsaga.diagnostic").show_line_diagnostics()
    end, opts)

    local client = vim.lsp.get_client_by_id(args.data.client_id)

    -- Navigate code.
    if client.server_capabilities.definitionProvider then
      vim.keymap.set("n", "gy", vim.lsp.buf.type_definition, opts)
      vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
    end

    -- Show documentation.
    vim.keymap.set("n", "K", function()
      require("lspsaga.hover").render_hover_doc()
    end, opts)

    -- Refactor code.
    vim.keymap.set("n", "<leader>rn", function()
      require("lspsaga.rename").rename()
    end, opts)

    if client.server_capabilities.documentFormattingProvider then
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = vim.api.nvim_create_augroup("format-on-save", {}),
        pattern = "<buffer>",
        callback = function()
          vim.lsp.buf.format({ timeout_ms = 5000 })
        end,
      })
    end

    vim.api.nvim_create_autocmd("CursorHold", {
      group = vim.api.nvim_create_augroup("show-diagnostics", { clear = true }),
      pattern = "<buffer>",
      callback = function()
        require("lspsaga.diagnostic").show_line_diagnostics()
      end,
    })
  end,
})

vim.lsp.handlers["textDocument/publishDiagnostics"] =
vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
  -- Disable virtual text globally.
  virtual_text = false,
})

-- Install any language servers that are missing.
local has_lspinstall, servers = pcall(require, "nvim-lsp-installer.servers")
if has_lspinstall then
  for server_name, _ in pairs(configs) do
    local _, server = servers.get_server(server_name)
    if not server:is_installed() then
      server:install()
    end
  end
end
