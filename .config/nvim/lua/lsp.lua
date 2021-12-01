local has_lspconfig, _ = pcall(require, "lspconfig")
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
    [[<cmd>lua require("lspsaga.diagnostic").navigate("prev")({ wrap = false })<cr>]],
    opts
  )
  noremap(
    "n",
    "]a",
    [[<cmd>lua require("lspsaga.diagnostic").navigate("next")({ wrap = false })<cr>]],
    opts
  )
  noremap(
    "n",
    "<leader>a",
    [[<cmd>lua require("lspsaga.diagnostic").show_line_diagnostics()<cr>]],
    opts
  )

  -- Navigate code.
  noremap("n", "gd", [[<cmd>lua vim.lsp.buf.definition()<cr>]], opts)
  noremap("n", "gy", [[<cmd>lua vim.lsp.buf.type_definition()<cr>]], opts)
  noremap("n", "gr", [[<cmd>lua vim.lsp.buf.references()<cr>]], opts)

  -- Show documentation.
  noremap(
    "n",
    "K",
    [[<cmd>lua require("lspsaga.hover").render_hover_doc()<cr>]],
    opts
  )

  -- Refactor code.
  noremap(
    "n",
    "<leader>rn",
    [[<cmd>lua require("lspsaga.rename").rename()<cr>]],
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
    [[ CursorHold <buffer> lua require("lspsaga.diagnostic").show_line_diagnostics() ]],
    true
  )
end

-- Set up language servers and include the configuration.
local disable_virtual_text = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics,
  { virtual_text = false }
)

local diagnosticls = require("diagnosticls")

local server_configs = {
  diagnosticls = {
    filetypes = { "fish", "lua", "python", "yaml" },
    init_options = {
      filetypes = {
        fish = { "fish" },
        python = { "flake8", "mypy" },
        yaml = { "yamllint" },
      },
      formatters = diagnosticls.formatters,
      formatFiletypes = {
        fish = { "fish_indent" },
        lua = { "stylua" },
        python = { "black", "isort" },
      },
      linters = diagnosticls.linters,
    },
  },
  jedi_language_server = {},
  rust_analyzer = {},
  sumneko_lua = {
    settings = {
      Lua = {
        diagnostics = {
          disable = { "lowercase-global" },
          globals = { "vim" },
        },
        telemetry = {
          enable = false,
        },
      },
    },
  },
}

local has_local_lsp, local_lsp = pcall(require, "lspextras")
if has_local_lsp then
  server_configs = local_lsp.merge(server_configs)
end

local has_lspinstall, servers = pcall(require, "nvim-lsp-installer.servers")
if has_lspinstall then
  for server_name, _ in pairs(server_configs) do
    local _, server = servers.get_server(server_name)
    server:on_ready(function()
      local defaults = {
        on_attach = on_attach,
        handlers = {
          ["textDocument/publishDiagnostics"] = disable_virtual_text,
        },
      }
      server:setup(
        vim.tbl_deep_extend("force", defaults, server_configs[server.name])
      )
    end)
    if not server:is_installed() then
      server:install()
    end
  end
end
