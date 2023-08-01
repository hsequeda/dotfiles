require'lualine'.setup {
  options = {
    icons_enabled = true,
    theme = 'catppuccin',
    section_separators = {'', ''},
    component_separators = {'', ''},
    disabled_filetypes = {}
  },
  sections = {
    lualine_a = {"mode" },
    lualine_b = {'branch'},
    lualine_c = {'filename'},
    lualine_x = {
      'encoding',
      'fileformat',
      'filetype',
      {"diagnostics", sources = {"nvim_diagnostic"}},
      {
        require("noice").api.statusline.mode.get,
        cond = require("noice").api.statusline.mode.has,
        color = { fg = "#ff9e64" },
      },

    },
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  extensions = {}
}
