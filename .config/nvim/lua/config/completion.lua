local noremap = require("config").noremap
local silent_expression = { silent = true, expr = true }

require("compe").setup({
  enabled = true,
  autocomplete = true,
  debug = false,
  min_length = 1,
  preselect = "enable",
  throttle_time = 80,
  source_timeout = 200,
  resolve_timeout = 800,
  incomplete_delay = 400,
  max_abbr_width = 100,
  max_kind_width = 100,
  max_menu_width = 100,
  documentation = {
    border = { "", "", "", " ", "", "", "", " " }, -- the border option is the same as `|help nvim_open_win|`
    winhighlight = "NormalFloat:CompeDocumentation,FloatBorder:CompeDocumentationBorder",
    max_width = 120,
    min_width = 60,
    max_height = math.floor(vim.o.lines * 0.3),
    min_height = 1,
  },

  source = {
    path = true,
    buffer = true,
    calc = true,
    nvim_lsp = true,
    nvim_lua = true,
  },
})

noremap("i", "<c-space>", "compe#complete()", silent_expression)
noremap("i", "<cr>", "compe#confirm('<cr>')", silent_expression)
noremap("i", "<c-e>", "compe#close('<c-e>')", silent_expression)
-- noremap('i', '<c-f>', "compe#scroll({ 'delta': +4 })", silent_expression)
-- noremap('i', '<c-d>', "compe#scroll({ 'delta': -4 })", silent_expression)
