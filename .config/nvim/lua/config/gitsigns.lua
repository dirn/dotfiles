require('gitsigns').setup({
  signs = {
    add = {
      text = '+',
    },
    change = {
      text = '~',
    },
    delete = {
      text = '_',
    },
    topdelete = {
      text = '‾',
    },
    changedelete = {
      text = '~_',
    },
  },
  yadm = {
    enable = true,
  },
})

-- gitsigns reverses the fg and bg colors and uses the background of the
-- number column rather than the background of the sign column. Fix that.
-- TODO: Is there a way to get the background from SignColumn?
vim.cmd [[ highlight GitSignsAdd gui=NONE guibg=NONE ctermbg=242 ]]
vim.cmd [[ highlight GitSignsChange gui=NONE guibg=NONE ctermbg=242 ]]
vim.cmd [[ highlight GitSignsDelete gui=NONE guibg=NONE ctermbg=242 ]]
