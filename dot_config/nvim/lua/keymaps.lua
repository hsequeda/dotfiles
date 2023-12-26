-----------------------------------------------------------
-- Keymaps configuration file: keymaps of neovim
-- and plugins.
-----------------------------------------------------------

local map = vim.api.nvim_set_keymap
local default_opts = { noremap = true, silent = true }

-----------------------------------------------------------
-- Neovim shortcuts:
-----------------------------------------------------------

-- clear search highlighting
map('n', '<leader>c', ':nohl<CR>', default_opts)

-- moving around buffers
map('n', '[b', ':bprevious<CR>', default_opts)
map('n', ']b', ':bnext<CR>', default_opts)

-- No more arrow
map('', '<Up>', '<NOT>', {noremap = true})
map('', '<Down>', '<NOT>', {noremap = true})
map('', '<Left>', '<NOT>', {noremap = true})
map('', '<Right>', '<NOT>', {noremap = true})

-- Mapped search
map('n', 'n', 'nzz', default_opts)
map('n', 'N', 'Nzz', default_opts)

-- Select paste text
map('n', 'gp', '`[v`]', {})

-----------------------------------------------------------
-- Applications & Plugins shortcuts:
-----------------------------------------------------------

-- Vim-Maximizer
map('','<C-w>m', ':MaximizerToggle<CR>', default_opts)

-- Buffer-Only
map('','<leader>bo', ':BufOnly<CR>', default_opts)
