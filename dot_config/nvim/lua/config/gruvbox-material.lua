local g = vim.g
local cmd = vim.cmd
local opt = vim.opt

opt.termguicolors = true


g.gruvbox_material_background = 'hard' -- soft / medium / hard

g.gruvbox_material_enable_bold = 1
g.gruvbox_material_enable_italic = 1
g.gruvbox_material_current_word = 'bold' -- grey background / bold / underline /italic
g.gruvbox_material_palette = 'mix' -- original / mix / material
cmd('colorscheme gruvbox-material')
cmd('set background=dark') -- light / dark
