local ok, lspsaga = pcall(require, "lspsaga")
if not ok then
  return
end

lspsaga.init_lsp_saga({
  error_sign = ">>",
  hint_sign = "--",
  infor_sign = "--",
  warn_sign = "--",
  dianostic_header_icon = "",
  rename_action_keys = {
    quit = {
      "<c-c>",
      "<c-d>",
      "<esc>",
    },
  },
})
