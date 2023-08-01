require('zellij').setup({
  replaceVimWindowNavigationKeybinds = false, -- Will set keybinds like <C-w>h to left
  vimTmuxNavigatorKeybinds = false, -- Will set keybinds like <C-h> to left
  debug = false, -- Will log things to /tmp/zellij.nvim
})

local map = vim.api.nvim_set_keymap
local default_opts = { noremap = true, silent = true }

-- map('', '<m-h>', '<cmd> ZellijNavigateLeft<CR>',default_opts)
-- map('', '<m-l>', '<cmd> ZellijNavigateRight<CR>',default_opts)
-- map('', '<m-j>', '<cmd> ZellijNavigateDown<CR>',default_opts)
-- map('', '<m-k>', '<cmd> ZellijNavigateUp<CR>',default_opts)
