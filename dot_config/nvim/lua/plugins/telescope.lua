require('telescope').setup {
  defaults = {
    mappings = {
      i = {
        ["<C-h>"] = "which_key"
      }
    }
  },
  pickers = {},
  extensions = {}
}

-- Using Lua functions
local opts = { noremap=true, silent=true }
local map = vim.api.nvim_set_keymap
map('n', '<C-p>', '<cmd>lua require("telescope.builtin").find_files()<cr>', opts) -- find files by file name
map('n', '<leader>fg', '<cmd>lua require("telescope.builtin").live_grep()<cr>', opts) -- find  files by content TODO: re-map
map('n', '<C-b>', '<cmd>lua require("telescope.builtin").buffers()<cr>', opts) -- find buffer by file name
map('n', '<leader>fh', '<cmd>lua require("telescope.builtin").help_tags()<cr>', opts) -- find ??? TODO: re-map
