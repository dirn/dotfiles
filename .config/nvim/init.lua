-- Set the leader first so that any plugins providing mappings will pick it up.
vim.g.mapleader = [[ ]]

-- Install plugins.
require("dirn.plugins")

-- Use my own idea of sensible defaults.
require("dirn.settings")

-- Register my keybindings.
require("dirn.bindings")

-- Configure language servers.
require("dirn.lsp")

-- Allow for system-specific configuration.
pcall(require, "dirn.extras")
