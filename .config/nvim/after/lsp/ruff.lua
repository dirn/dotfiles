return {
  init_options = {
    settings = {
      lint = {
        extendSelect = { "ALL" },
        ignore = {
          "C90", -- not all functions can be simplified
          "COM812", -- my code is autoformatted; if the line doesn't have a comma there's a reason
          "D1", -- I work with too much code that doesn't have docstrings
          "DTZ", -- flake8-datetimez doesn't like naive date(time)s
          "E501", -- my code is autoformatted; if the line is too long there's a reason
          "ERA", -- flake8-eradicate seems to have a lot of false positives
          "FIX", -- flake8-fixme wants me to fix everything
          "PL", -- I'm not a fan of pylint
          "S607", -- while this is reasonable, I don't always know the executable's full path
          "TD", -- flake8-todos doesn't like too many TODOs in code I don't own
          "TRY003", -- lots of built-in exceptions take the message as an argument
        },
        fixable = "ALL",
      },
    },
  },
}
