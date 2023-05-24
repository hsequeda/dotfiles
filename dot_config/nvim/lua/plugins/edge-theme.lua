local g = vim.g
local cmd = vim.cmd
local opt = vim.opt

opt.termguicolors = true


g.edge_background = 'hard' -- soft / medium / hard

g.edge_enable_bold = 1
g.edge_enable_bold = 1
g.edge_enable_italic = 1
g.edge_current_word = 'bold' -- grey background / bold / underline /italic
g.edge_palette = 'mix' -- original / mix / material
cmd('colorscheme edge')
cmd('set background=light') -- light / dark
