local has_mason, _ = pcall(require, "mason")
if not has_mason then
  return
end

local server_path = require("mason-core.path").bin_prefix

return {
  cmd = { server_path("lua-language-server") },
  filetypes = { "lua" },
  root_markers = {
    "stylua.toml",
    ".git",
  },
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
}
