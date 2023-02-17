local ok, harpoon = pcall(require, "harpoon")
if not ok then
  return
end

local ok, telescope = pcall(require, "telescope")
if ok then
  telescope.load_extension("harpoon")
end

harpoon.setup()
