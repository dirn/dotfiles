---@param event string|string[]
---@param callback fun(args: table)
---@param opts? {schedule?: boolean}
function load_on(event, callback, opts)
  opts = opts or {}

  vim.api.nvim_create_autocmd(event, {
    once = true,
    callback = opts.schedule and vim.schedule_wrap(callback) or callback,
  })
end
