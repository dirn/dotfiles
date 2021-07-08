local config = require('config')
noremap = config.noremap

local silent = { silent = true }

noremap('i', 'jk', '<esc>')

-- The following set of previous/next/first/last mappings are inspired by
-- (borrowed from) https://github.com/tpope/vim-unimpaired.
-- Navigate buffers.
noremap('n', '[b', '<cmd>bprevious<cr>', silent)
noremap('n', ']b', '<cmd>bnext<cr>', silent)
noremap('n', '[B', '<cmd>bfirst<cr>', silent)
noremap('n', ']B', '<cmd>blast<cr>', silent)

-- Navigate the location list.
noremap('n', '[l', '<cmd>lprevious<cr>', silent)
noremap('n', ']l', '<cmd>lnext<cr>', silent)
noremap('n', '[L', '<cmd>lfirst<cr>', silent)
noremap('n', ']L', '<cmd>llast<cr>', silent)

-- Navigate the quickfix list.
noremap('n', '[q', '<cmd>qprevious<cr>', silent)
noremap('n', ']q', '<cmd>qnext<cr>', silent)
noremap('n', '[Q', '<cmd>qfirst<cr>', silent)
noremap('n', ']Q', '<cmd>qlast<cr>', silent)

-- Navigate tabs (these differ from vim-unimpaired).
noremap('n', '[t', '<cmd>tprevious<cr>', silent)
noremap('n', ']t', '<cmd>tnext<cr>', silent)
noremap('n', '[T', '<cmd>tfirst<cr>', silent)
noremap('n', ']T', '<cmd>tlast<cr>', silent)

-- Copy and paste using the system clipboard.
noremap('v', '<leader>y', '"+y')
noremap('v', '<leader>d', '"+d')
noremap({ 'n', 'v' }, '<leader>p', '"+p')
noremap({ 'n', 'v' }, '<leader>P', '"+P')

-- Selected the text that was just pasted.
noremap('n', 'gp', '`[v`]')
