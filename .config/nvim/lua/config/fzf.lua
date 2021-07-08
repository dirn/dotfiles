local noremap = require('config').noremap
local silent = { silent = true }

-- Fuzzy find files.
noremap('n', '<c-p>', '<cmd>GitFiles<cr>', silent)
noremap('n', '<leader>rg', '<cmd>Rg<cr>', silent)
noremap('n', '<leader>ls', '<cmd>Buffers<cr>', silent)
