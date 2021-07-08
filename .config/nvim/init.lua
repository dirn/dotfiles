-- Set the leader first so that any plugins providing mappings will pick it up.
vim.g.mapleader = [[ ]]

-- Install plugins.
require('plugins')

-- Use my own idea of sensible defaults.
require('settings')

-- Register my keybindings.
require('bindings')

-- Configure language servers.
require('lsp')

-- Allow for system-specific configuration.
pcall(require, 'extras')
