local has_mason, mason = pcall(require, "mason")
if not has_mason then
  return
end

local has_installer, installer = pcall(require, "mason-tool-installer")
if not has_installer then
  return
end

mason.setup()
installer.setup({
  ensure_installed = {
    "black",
    "diagnosticls",
    "jedi-language-server",
    "lua-language-server",
    "mypy",
    "prettier",
    "ruff",
    "rust-analyzer",
    "stylua",
    "yamllint",
  },
})

local servers = {
  "diagnosticls",
  "jedi_language_server",
  "lua_ls",
  "rust_analyzer",
}

local has_lspextras, lspextras = pcall(require, "dirn.lspextras")
if has_lspextras then
  vim.list_extend(servers, lspextras)
end

vim.lsp.enable(servers)

vim.api.nvim_create_autocmd("LspAttach", {
  desc = "Configure the buffer's capabilities.",
  callback = function(args)
    -- Navigate diagnostics.
    vim.keymap.set("n", "[a", function()
      vim.diagnostic.jump({ count = -1, float = true, wrap = false })
    end, {
      desc = "Go to the previous diagnostics.",
      buffer = args.buf,
      noremap = true,
      silent = true,
    })
    vim.keymap.set("n", "]a", function()
      vim.diagnostic.jump({ count = 1, float = true, wrap = false })
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

    local client = assert(vim.lsp.get_client_by_id(args.data.client_id))

    -- Navigate code.
    if client:supports_method("textDocument/definition") then
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
