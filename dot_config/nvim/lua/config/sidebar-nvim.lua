local sidebar = require("sidebar-nvim")
vim.api.nvim_set_keymap('n', '<m-2>', '<cmd>SidebarNvimToggle<CR>', {noremap=true, silent=true})

sidebar.setup({
  open = false,
  side = 'right',
  -- sections = { "datetime", "git", "diagnostics", "symbols" },
  sections = { "git", "diagnostics", "symbols" },
  symbols = {
    icon = "ƒ",
  },
})
