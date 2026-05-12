vim.pack.add({
  "https://github.com/nvim-treesitter/nvim-treesitter",
  "https://github.com/nvim-treesitter/nvim-treesitter-textobjects",
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "*",
  group = vim.api.nvim_create_augroup("treesitter", { clear = true }),
  callback = function(ev)
    local lang = vim.treesitter.language.get_lang(ev.match) or ev.match
    local ok = vim.treesitter.language.add(lang)

    if not ok then
      return
    end

    -- highlighting
    vim.treesitter.start(ev.buf, lang)

    -- indentation
    vim.bo[ev.buf].indentexpr = "v:lua.require('nvim-treesitter').indentexpr()"
  end,
})

vim.api.nvim_create_autocmd("PackChanged", {
  callback = function(ev)
    local name, kind = ev.data.spec.name, ev.data.kind
    if name == "nvim-treesitter" and kind == "update" then
      if not ev.data.active then
        vim.cmd.packadd("nvim-treesitter")
      end
      vim.cmd("TSUpdate")
    end
  end,
})

vim.schedule(function()
  local ts = require("nvim-treesitter")

  local desired = {
    "bash",
    "c",
    "comment",
    "css",
    "csv",
    "diff",
    "dockerfile",
    "editorconfig",
    "fish",
    "git_config",
    "git_rebase",
    "gitcommit",
    "gitignore",
    "go",
    "html",
    "java",
    "javadoc",
    "javascript",
    "json",
    "lua",
    "luadoc",
    "luap",
    "markdown",
    "markdown_inline",
    "muttrc",
    "printf",
    "proto",
    "python",
    "regex",
    "requirements",
    "rst",
    "rust",
    "sql",
    "ssh_config",
    "starlark",
    "tmux",
    "toml",
    "vim",
    "vimdoc",
    "xml",
    "yaml",
  }

  local available = {}
  for _, parser in ipairs(ts.get_available()) do
    available[parser] = true
  end

  local parsers = vim.tbl_filter(function(parser)
    return available[parser]
  end, desired)

  ts.install(parsers)
end)

require("nvim-treesitter").setup()
vim.api.nvim_set_hl(0, "@docstring", { link = "TSString" })

local select = require("nvim-treesitter-textobjects.select")
for key, capture in pairs({
  c = "@class",
  f = "@function",
}) do
  vim.keymap.set({ "x", "o" }, "a" .. key, function()
    select.select_textobject(capture .. ".outer", "textobjects")
  end)

  vim.keymap.set({ "x", "o" }, "i" .. key, function()
    select.select_textobject(capture .. ".inner", "textobjects")
  end)
end

local move = require("nvim-treesitter-textobjects.move")
for key, capture in pairs({
  c = "@class.outer",
  f = "@function.outer",
}) do
  vim.keymap.set({ "n", "x", "o" }, "]" .. key, function()
    move.goto_next_start(capture, "textobjects")
  end)
  vim.keymap.set({ "n", "x", "o" }, "[" .. key, function()
    move.goto_previous_start(capture, "textobjects")
  end)

  local upper = key:upper()
  vim.keymap.set({ "n", "x", "o" }, "]" .. upper, function()
    move.goto_next_end(capture, "textobjects")
  end)
  vim.keymap.set({ "n", "x", "o" }, "[" .. upper, function()
    move.goto_previous_end(capture, "textobjects")
  end)
end
