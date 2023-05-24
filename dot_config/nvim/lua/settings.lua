-----------------------------------------------------------
-- Neovim settings
-----------------------------------------------------------


-----------------------------------------------------------
-- Neovim API aliases
-----------------------------------------------------------

local cmd = vim.cmd -- execute Vim commands
local exec = vim.api.nvim_exec  -- execute Vimscript
-- local fn = vim.fn -- call Vim functions
local g = vim.g -- global variables
local opt = vim.opt -- global/buffer/windows-scoped options

-----------------------------------------------------------
-- General
-----------------------------------------------------------

g.mapleader = '\\' -- set leader as \
opt.mouse= 'a'
opt.clipboard = 'unnamedplus'
opt.swapfile = true -- default true

-----------------------------------------------------------
-- Neovim UI
-----------------------------------------------------------
opt.number = true           -- show line number
opt.relativenumber = true   -- show line number
opt.showmatch = true        -- highlight matching parenthesis
opt.foldmethod = 'manual' -- enable folding (default '')
opt.colorcolumn = '80' -- line lenght marker at 80 columns
opt.splitright = true -- vertical split to the right
opt.splitbelow = true -- horizontal split to the botton
opt.ignorecase = true -- ignore case letters when search
opt.smartcase = true -- ignore lowercase for the whole case
opt.linebreak = true -- wrap on word boundary
opt.conceallevel = 0
opt.termguicolors = true
opt.list = true
opt.listchars = 'tab:▸ ,space:·,nbsp:␣,trail:•,precedes:«,extends:»'
opt.cmdheight = 1 -- Number of screen lines to use for the command-line
opt.nrformats = { 'alpha', 'bin', 'hex', 'octal' } -- This defines what bases Vim will consider for numbers when using the CTRL-A and CTRL-X commands.
opt.winbar='%=%m %f'


opt.cursorline = true -- highlight the current line

-- remove whitespace on save
cmd [[au BufWritePre * :%s/\s\+$//e]]

-- highlight on yank
exec([[
  augroup YankHighlight
    autocmd!
    autocmd TextYankPost * silent! lua vim.highlight.on_yank{ higroup="IncSearch", timeout=700 }
  augroup end
]], false)

-----------------------------------------------------------
-- Memory, CPU
-----------------------------------------------------------
opt.hidden = true         -- enable background buffers
opt.history = 100         -- remember n lines in history
opt.lazyredraw = true     -- faster scrolling
opt.synmaxcol = 1000       -- max column for syntax highlight

-----------------------------------------------------------
-- Tabs, indent
-----------------------------------------------------------

opt.expandtab = true -- use spaces instead of tabs
opt.shiftwidth = 4 -- shift 4 spaces when tab
opt.tabstop = 4	-- tab == 4 spaces
opt.softtabstop = 4
opt.smartindent = true -- autoindent new lines
opt.shiftround = false

-- don't auto commenting new lines
cmd [[au BufEnter * set fo-=c fo-=r fo-=o]]

-- remove line lenght marker for selected filetypes
cmd [[autocmd FileType text,markdown,html,xhtml,javascript setlocal cc=0]]

-- 2 spaces for selected filetypes
cmd [[
  autocmd FileType xml,javascript,rust,go,typescript,lua,yaml,proto setlocal shiftwidth=2 tabstop=2 softtabstop=2
]]

g.indentLine_char = '|' -- set indentLine character

-- disable IndentLine for markdown files (avoid concealing)
cmd [[autocmd FileType markdown let g:indentLine_enabled=0]]

-----------------------------------------------------------
-- Autocompletion
-----------------------------------------------------------

-- defined in nvim-cmp.lua

-----------------------------------------------------------
-- Terminal
-----------------------------------------------------------

-- open a terminal pane on the right using :Term
cmd [[command Term :botright vsplit term://$SHELL]]

-- Terminal visual tweaks
--- enter intert mode when switching to terminal
--- close terminal buffer on process exit
cmd [[
  autocmd TermOpen * setlocal listchars= nonumber norelativenumber nocursorline
  autocmd TermOpen * startinsert
  autocmd BufLeave term://* stopinsert
]]
