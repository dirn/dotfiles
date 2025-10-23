return {
  filetypes = { "fish", "lua", "python", "yaml" },
  init_options = {
    filetypes = {
      fish = { "fish" },
      python = { "mypy" },
      yaml = { "yamllint" },
    },
    formatFiletypes = {
      python = "", -- Don't try to format Python files.
    },
  },
}
