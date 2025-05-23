return {
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
