require('telescope').setup {
  defaults = {
    mappings = {
      i = {
        ["<C-h>"] = "which_key"
      }
    }
  },
  pickers = {},
  extensions = {"dap"}
}

-- Using Lua functions
local opts = { noremap=true, silent=true }
local map = vim.api.nvim_set_keymap
map('n', '<C-p>', '<cmd>lua require("telescope.builtin").find_files()<cr>', opts) -- find files by file name
map('n', '<leader>fg', '<cmd>lua require("telescope.builtin").live_grep()<cr>', opts) -- find regexp
map('n', '<leader>fb', '<cmd>lua require("telescope.builtin").buffers()<cr>', opts) -- find buffer by file name
-- map('n', '<leader>fh', '<cmd>lua require("telescope.builtin").help_tags()<cr>', opts) -- find help tags
map('n', '<leader>fd', '<cmd>lua require("telescope.builtin").diagnostics()<cr>', opts) -- find lsp diagnostic
-- map('n', '<leader>fh', '<cmd>Telescope noice<CR>', opts) -- find notification history
