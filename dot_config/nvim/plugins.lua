local Plug = vim.fn['plug#']

vim.call('plug#begin', '~/.config/nvim/plugged')

Plug 'sainnhe/gruvbox-material'
Plug 'sainnhe/edge'
Plug 'sainnhe/sonokai'
Plug 'sainnhe/everforest'

Plug 'hoob3rt/lualine.nvim'

Plug 'kyazdani42/nvim-tree.lua'

Plug 'kyazdani42/nvim-web-devicons'

Plug 'ryanoasis/vim-devicons'

Plug 'onsails/lspkind-nvim'

Plug 'neovim/nvim-lspconfig'

Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/cmp-nvim-lsp-signature-help'
Plug 'hrsh7th/nvim-cmp'

Plug 'L3MON4D3/LuaSnip'
Plug 'saadparwaiz1/cmp_luasnip'

Plug 'akinsho/bufferline.nvim'

Plug 'tpope/vim-surround'

Plug 'tpope/vim-commentary'

Plug 'tpope/vim-abolish'

Plug 'rust-lang/rust.vim'

Plug ('iamcco/markdown-preview.nvim', {['do'] = vim.fn['cd app & yarn install']})

-- Plug 'SirVer/ultisnips'
-- Plug 'quangnguyen30192/cmp-nvim-ultisnips'

-- Plug 'jiangmiao/auto-pairs'

Plug 'windwp/nvim-autopairs'

-- Require neovim >= 0.6
Plug ('nvim-treesitter/nvim-treesitter', {['do'] = vim.fn[':TSUpdate']})  -- We recommend updating the parsers on update
Plug 'nvim-treesitter/nvim-treesitter-textobjects'
Plug 'nvim-treesitter/playground'

Plug 'nvim-lua/plenary.nvim'

Plug 'nvim-telescope/telescope.nvim'

Plug 'lukas-reineke/indent-blankline.nvim'

Plug 'kana/vim-textobj-user'

Plug 'kana/vim-textobj-entire'

-- Plug 'sebdah/vim-delve'

-- Plug 'liuchengxu/vista.vim'

-- TODO fix conflict with vim-abolish
-- Plug 'vim-scripts/vis'
-- command! -nargs=1 -bang -bar -range=0 S <line1>,<line2>Subvert<bang> <args>

Plug 'nvim-lua/plenary.nvim'

Plug 'sindrets/diffview.nvim'

Plug 'lewis6991/gitsigns.nvim'

Plug 'ray-x/go.nvim'

Plug ('ray-x/guihua.lua', {['do'] = vim.fn['cd lua/fzy && make']})

Plug 'mfussenegger/nvim-dap'

Plug 'rcarriga/nvim-dap-ui'

Plug 'theHamsta/nvim-dap-virtual-text'

Plug 'nvim-telescope/telescope-dap.nvim'

-- Plug 'ray-x/navigator.lua'

Plug 'ray-x/lsp_signature.nvim'

Plug 'ldelossa/litee.nvim'
Plug 'ldelossa/gh.nvim'


vim.call('plug#end')

