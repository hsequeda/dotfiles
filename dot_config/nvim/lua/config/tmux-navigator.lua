local map = vim.api.nvim_set_keymap
local default_opts = { noremap = true, silent = true }

map('', '<C-h>', '<cmd> TmuxNavigateLeft<CR>',default_opts)
map('', '<C-l>', '<cmd> TmuxNavigateRight<CR>',default_opts)
map('', '<C-j>', '<cmd> TmuxNavigateDown<CR>',default_opts)
map('', '<C-k>', '<cmd> TmuxNavigateUp<CR>',default_opts)
