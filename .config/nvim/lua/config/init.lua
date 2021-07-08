local function autocmd(group, commands, clear)
  clear = clear == nil and false or clear
  if type(commands) == 'string' then commands = { commands } end
  vim.cmd('augroup ' .. group)
  if clear then vim.cmd [[ autocmd! ]] end
  for _, c in ipairs(commands) do vim.cmd('autocmd ' .. c) end
  vim.cmd [[ augroup END ]]
end

local function remap(modes, lhs, rhs, opts)
  opts = opts or {}
  opts.noremap = opts.noremap == nil and true or opts.noremap
  if type(modes) == 'string' then modes = { modes } end
  for _, m in ipairs(modes) do vim.api.nvim_set_keymap(m, lhs, rhs, opts) end
end

local function noremap(modes, lhs, rhs, opts)
  opts = opts or {}
  opts.noremap = true
  remap(modes, lhs, rhs, opts)
end

return { autocmd = autocmd, noremap = noremap, remap = remap }
