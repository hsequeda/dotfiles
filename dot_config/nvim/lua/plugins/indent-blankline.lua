-----------------------------------------------------------
-- Indent line configuration file
-----------------------------------------------------------

-- Plugin: indent-blankline
-- https://github.com/lukas-reineke/indent-blankline.nvim


vim.opt.list = true
vim.opt.listchars:append("eol:↴")
require('indent_blankline').setup {
  char = "▏",
  show_first_indent_level = false,
  show_current_context = true,
  show_current_context_start = true,
  show_end_of_line = true,
  filetype_exclude = {
    'help',
    'git',
    'markdown',
    'text',
    'terminal',
    'lspinfo',
    'packer'
  },
  buftype_exclude = {
    'terminal',
    'nofile'
  },
}
