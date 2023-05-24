--[[
  ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
  ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║
  ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║
  ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║
  ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
  ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝
Neovim init file
Version: 0.43.0 - 2022/01/11
Maintainer: brainf+ck
Website: https://github.com/brainfucksec/neovim-lua
--]]

-----------------------------------------------------------
-- Import Lua modules
-----------------------------------------------------------
require('settings')
require('keymaps')
require('lsp-config.go')
require('lsp-config.rust')
require('lsp-config.tsserver')
-- require('plugins/packer')
-- require('plugins.luasnip_conf')
require('plugins/nvim-tree')
require('plugins/nvim-treesitter')
require('plugins/bufferline')
require('plugins/lualine')
require('plugins.gruvbox-material-theme')
-- require('plugins.edge-theme')
require('plugins/vim-go')
require('plugins/nvim-cmp')
require('plugins/telescope')
require('plugins/indent-blankline')
require('plugins/gitsign')
require('plugins/vista')
require('plugins/nvim-lspconfig')
require('plugins/go-nvim')
-- require('plugins/navigator')
require('plugins/guihua')
require('plugins.nvim-autopairs')
require('plugins/gh_nvim')
