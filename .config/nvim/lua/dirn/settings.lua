-- Some of these settings are already the default, but sometimes plugins do
-- silly things.

vim.opt.encoding = "utf8"

-- Handle whitespace.
vim.opt.autoindent = true
vim.opt.backspace = "indent,eol,start"
vim.opt.smarttab = true

-- I use things like pre-commit to run fixers on my code. The problem with that
-- is that if I start making changes before reloading the buffer, pre-commit
-- will reject the commit again or, even worse, I'll end up with merge
-- conflicts. This will automatically reload it when something else changes it.
vim.opt.autoread = true
vim.api.nvim_create_autocmd({ "BufEnter", "FocusGained" }, {
  desc = "Reload the buffer if the file was modified outside of Neovim.",
  command = "checktime",
})

-- Set the maximum length of lines.
vim.opt.textwidth = 80
-- Wrap lines based on characters, not line length.
vim.opt.linebreak = true
-- That said, don't wrap lines.
vim.opt.wrap = false

-- I find that swap and backup files cause more trouble than they're worth so
-- disable them.
vim.opt.backup = false
vim.opt.swapfile = false
vim.opt.writebackup = false

-- While I don't use it much, having mouse support can be nice from time to
-- time.
vim.opt.mouse = "a"

-- Highlight the current line.
vim.opt.cursorline = true
-- Highlight matching brackets.
vim.opt.showmatch = true
-- ...including angle brackets.
vim.opt.matchpairs = vim.opt.matchpairs + "<:>"

-- Highlight conflict markers as errors.
vim.cmd([[ match ErrorMsg '^\(<\|=\|>\)\{7\}\([^=].\+\)\?$' ]])

-- Show a rule at the width of the text.
if vim.fn.exists("&colorcolumn") > 0 then
  vim.opt.colorcolumn = "+1"
end

-- Replace all matches in a line, not just the first.
vim.opt.gdefault = true
-- Highlight all matches.
vim.opt.hlsearch = true
-- ...and begin doing so immediately.
vim.opt.incsearch = true
-- Make search case insensitive.
vim.opt.ignorecase = true
-- ...unless an uppercase letter is used.
vim.opt.smartcase = true

-- Always show the status line.
vim.opt.laststatus = 2
-- ...along with the current line and column positions.
vim.opt.ruler = true

-- Show relative line numbers.
vim.opt.relativenumber = true
-- But show the current line's number.
vim.opt.number = true

-- Set the window title, defaulting to the name of the current file.
vim.opt.title = true

-- Use spell check.
vim.opt.spell = true

-- Make horizontal scrolling smoother.
vim.opt.sidescroll = 1

-- Leave some padding at the top or bottom of the window when scrolling.
vim.opt.scrolloff = 2

-- Turn off folding and automatically expand all folds.
vim.opt.foldenable = false

-- When completing in insert mode:
--   - show the menu even when there's only one match
--   - only insert from the menu when told
vim.opt.completeopt = "menuone,noinsert,noselect"
-- Don't give completion-related messages.
vim.opt.shortmess = vim.opt.shortmess + "c"

-- Open new splits to the right and bottom.
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Always open diff in vertical splits.
vim.opt.diffopt = vim.opt.diffopt + "vertical"

-- Jump to the last known cursor position if it's valid (from the docs).
vim.api.nvim_create_autocmd("BufReadPost", {
  desc = "Restore the cursor position when reopening the buffer.",
  group = vim.api.nvim_create_augroup("last-position-jump", { clear = true }),
  callback = function()
    local row
    if vim.bo.filetype == "gitcommit" then
      row = 1
    else
      row, _ = unpack(vim.api.nvim_buf_get_mark(0, '"'))
      if row == nil then
        row = 1
      else
        -- If the file has never lines than the previous position, go to the end.
        local last_line = vim.api.nvim_buf_line_count(0)
        if row > last_line then
          row = last_line
        end
      end
    end

    if row > 0 then
      vim.api.nvim_win_set_cursor(0, { row, 0 })
    end
  end,
})

vim.api.nvim_set_var("markdown_fenced_languages", { "python" })
