local has_mason, _ = pcall(require, "mason")
if not has_mason then
  return
end

local server_path = require("mason-core.path").bin_prefix

local has_diagnosticls, diagnosticls = pcall(require, "diagnosticls")
if not has_diagnosticls then
  return {}
end

return {
  cmd = { server_path("diagnostic-languageserver"), "--stdio" },
  filetypes = { "fish", "lua", "python", "yaml" },
  root_markers = {
    ".editorconfig",
    "stylua.toml",
    ".git",
  },
  init_options = {
    linters = vim.tbl_deep_extend("force", diagnosticls.linters, {
      ruff = {
        sourceName = "ruff",
        command = server_path("ruff"),
        args = { "--extend-select=ASYNC,B,I,N", "%file" },
        rootPatterns = {
          "pyproject.toml",
          "requirements.txt",
          "setup.cfg",
          "setup.py",
        },
        formatPattern = {
          -- "^.*:(\\d+?):(\\d+?): ([A-Z]+)\\d+?: \\[\\*\\] (.*)$",
          "(\\d+):(\\d+): (([A-Z]+)(.*))(\\r|\\n)*$",
          {
            line = 1,
            column = 2,
            security = 4,
            message = 3,
          },
        },
        securities = {
          ASYNC = "error",
          B = "error",
          C = "error",
          E = "error",
          F = "error",
          I = "warning",
          N = "error",
          W = "warning",
        },
      },
    }),
    filetypes = {
      fish = { "fish" },
      python = { "mypy", "ruff" },
      yaml = { "yamllint" },
    },
  },
}
