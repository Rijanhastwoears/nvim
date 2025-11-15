-- Keymappings ---
vim.g.mapleader = " "
-- Map double space to escape in insert mode
vim.keymap.set("i", "<space><space>", "<esc>", { noremap = true, silent = true, desc = "Escape insert mode" })

vim.keymap.set('n', '<leader>w', ':w<CR>')
vim.keymap.set('n', '<leader>q', ':q<CR>')

require("plugins")

-- Basic settings
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.autoindent = true

-- Set a shorter timeout for key sequences, crucial for the double-space mapping
vim.opt.timeoutlen = 300

-- colorscheme --
vim.cmd.colorscheme "onedark"

-- registers --
vim.fn.setreg('p', 'V}k:j\n')
