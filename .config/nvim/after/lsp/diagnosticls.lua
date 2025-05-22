local has_diagnosticls, diagnosticls = pcall(require, "diagnosticls")
if not has_diagnosticls then
  return {}
end

return {
  filetypes = { "fish", "lua", "python", "yaml" },
  init_options = {
    linters = vim.tbl_deep_extend("force", diagnosticls.linters, {
      ruff = {
        sourceName = "ruff",
        command = "ruff",
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
