require("symbols-outline").setup({})

-- vim.cmd([[nnoremap <m-2> :SymbolsOutline<CR>]])
vim.api.nvim_set_keymap('n', '<m-2>', '<cmd>SymbolsOutline<CR>', {noremap=true, silent=true})
