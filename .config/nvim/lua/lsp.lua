local has_lspconfig, lspconfig = pcall(require, "lspconfig")
if has_lspconfig == false then
  return
end

local config = require("config")
autocmd = config.autocmd
noremap = config.noremap

local opts = { silent = true }

local on_attach = function(client, bufnr)
  -- Navigate diagnostics.
  noremap(
    "n",
    "[a",
    [[<cmd>lua require('lspsaga.diagnostic').lsp_jump_diagnostic_prev({ wrap = false })<cr>]],
    opts
  )
  noremap(
    "n",
    "]a",
    [[<cmd>lua require('lspsaga.diagnostic').lsp_jump_diagnostic_next({ wrap = false })<cr>]],
    opts
  )
  noremap(
    "n",
    "<leader>a",
    [[<cmd>lua require('lspsaga.diagnostic').show_line_diagnostics()<cr>]],
    opts
  )

  -- Navigate code.
  noremap("n", "gd", [[ <cmd>lua vim.lsp.buf.definition()<cr> ]], opts)
  noremap("n", "gy", [[ <cmd>lua vim.lsp.buf.type_definition()<cr> ]], opts)
  noremap("n", "gr", [[ <cmd>lua vim.lsp.buf.references()<cr> ]], opts)

  -- Show documentation.
  noremap(
    "n",
    "K",
    [[ <cmd>lua require('lspsaga.hover').render_hover_doc()<cr> ]],
    opts
  )

  -- Refactor code.
  noremap(
    "n",
    "<leader>rn",
    [[<cmd>lua require('lspsaga.rename').rename()<cr>]],
    opts
  )

  -- Format on save. If the augroup isn't cleared, multiple LSPs attaching to a
  -- buffer would attach this autocmd multiple times.
  if client.resolved_capabilities.document_formatting then
    autocmd(
      "format-on-save",
      [[ BufWritePre <buffer> lua vim.lsp.buf.formatting_sync(nil, 5000) ]],
      true
    )
  end

  autocmd(
    "show-diagnostics",
    [[ CursorHold <buffer> lua require('lspsaga.diagnostic').show_line_diagnostics() ]],
    true
  )
end

-- Set up language servers and include the configuration.
local black = { command = "black", args = { "--quiet", "-" } }

local flake8 = {
  sourceName = "flake8",
  command = "flake8",
  debounce = 100,
  args = { "--format=%(row)d,%(col)d,%(code).1s,%(code)s: %(text)s", "-" },
  offsetLine = 0,
  offsetColumn = 0,
  formatLines = 1,
  formatPattern = {
    "(\\d+),(\\d+),([A-Z]),(.*)(\\r|\\n)*$",
    { line = 1, column = 2, security = 3, message = 4 },
  },
  securities = {
    W = "warning",
    E = "error",
    F = "error",
    C = "error",
    N = "error",
  },
}

local isort = { command = "isort", args = { "--quiet", "-" } }

local mypy = {
  sourceName = "mypy",
  command = "mypy",
  args = {
    "--no-color-output",
    "--no-error-summary",
    "--show-column-numbers",
    "--follow-imports=silent",
    "%file",
  },
  formatPattern = {
    "^.*:(\\d+?):(\\d+?): ([a-z]+?): (.*)$",
    { line = 1, column = 2, security = 3, message = 4 },
  },
  securities = { error = "error" },
}

local stylua = {
  command = "stylua",
  args = {
    "--search-parent-directories",
    "--verify",
    "-",
  },
}

local disable_virtual_text = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics,
  { virtual_text = false }
)

local server_configs = {
  diagnosticls = {
    filetypes = { "lua", "python" },
    init_options = {
      filetypes = { python = { "flake8", "mypy" } },
      formatters = { black = black, isort = isort, stylua = stylua },
      formatFiletypes = {
        lua = { "stylua" },
        python = { "black", "isort" },
      },
      linters = { flake8 = flake8, mypy = mypy },
    },
    on_attach = on_attach,
    handlers = { ["textDocument/publishDiagnostics"] = disable_virtual_text },
  },
  jedi_language_server = {
    on_attach = on_attach,
    handlers = { ["textDocument/publishDiagnostics"] = disable_virtual_text },
  },
  lua = {
    filetypes = { "lua" },
    settings = {
      Lua = {
        diagnostics = {
          disable = { "lowercase-global" },
          globals = { "vim" },
        },
      },
    },
    on_attach = on_attach,
    handlers = { ["textDocument/publishDiagnostics"] = disable_virtual_text },
  },
}

local has_local_lsp, local_lsp = pcall(require, "lspextras")
if has_local_lsp then
  server_configs = local_lsp.merge(server_configs)
end

local has_lspinstall, lspinstall = pcall(require, "lspinstall")
if has_lspinstall then
  -- This exists until lspinstall supports this server.
  local jedi_config = lspconfig.jedi_language_server.document_config
  require("lspconfig/configs").jedi_language_server = nil
  jedi_config.default_config.cmd[1] = "./venv/bin/jedi-language-server"
  require("lspinstall/servers").jedi_language_server = vim.tbl_extend(
    "error",
    jedi_config,
    {
      install_script = [[
      python3 -m venv ./venv
      ./venv/bin/pip3 install --upgrade pip
      ./venv/bin/pip3 install --upgrade jedi-language-server
    ]],
    }
  )

  lspinstall.setup()
  local servers = lspinstall.installed_servers()

  for server, _ in pairs(server_configs) do
    if vim.tbl_contains(servers, server) == false then
      lspinstall.install_server(server)
    end
  end

  for _, server in ipairs(servers) do
    lspconfig[server].setup(server_configs[server])
  end
end
