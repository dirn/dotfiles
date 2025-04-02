local has_mason, _ = pcall(require, "mason")
if not has_mason then
  return
end

local server_path = require("mason-core.path").bin_prefix

return {
  cmd = { server_path("jedi-language-server") },
  filetypes = { "python" },
  root_markers = {
    "pyproject.toml",
    "requirements.txt",
    "setup.cfg",
    "setup.py",
    ".git",
  },
}
