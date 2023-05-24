-----------------------------------------------------------
-- File manager configuration file
-----------------------------------------------------------

-- Plugin: nvim-tree
-- https://github.com/kyazdani42/nvim-tree.lua

-- Keybindings are defined in `keymapping.lua`:
--- https://github.com/kyazdani42/nvim-tree.lua#keybindings

-- Note: options under the g: command should be set BEFORE running the
--- setup function:
--- https://github.com/kyazdani42/nvim-tree.lua#setup
--- See: `help NvimTree`

local g = vim.g

g.nvim_tree_side = 'left' -- left by default ( left / right )
g.nvim_tree_width = 40 -- 30 by default, can be width_in_columns or 'width_in_percent%'
g.nvim_tree_auto_ignore_ft = {'startify', 'dashboard'} -- empty by default, don't auto open tree on specific filetypes.

require('nvim-tree').setup {

 -- disables netrw completely
  disable_netrw       = false,
  -- hijack netrw window on startup
  hijack_netrw        = true,
  -- open the tree when running this setup function
  -- open_on_setup       = false,
  -- will not open on setup if the filetype is in this list
  -- ignore_ft_on_setup  = {},
  -- opens the tree when changing/opening a new tab if the tree wasn't previously opened
  open_on_tab         = false,
  -- hijack the cursor in the tree to put it at the start of the filename
  hijack_cursor       = false,
  -- updates the root directory of the tree on `DirChanged` (when your run `:cd` usually)
  update_cwd          = false,

  respect_buf_cwd = true,

  -- hijacks new directory buffers when they are opened.
  hijack_directories = {
    enable = true,
    auto_open = true,
  },
  -- show lsp diagnostics in the signcolumn
  diagnostics = {
    enable = false,
    icons = {
      error = "",
      warning = "",
      hint = "",
      info = ""
    }
  },
  -- update the focused file on `BufEnter`, un-collapses the folders recursively until it finds the file
  update_focused_file = {
    -- enables the feature
    enable      = false,
    -- update the root directory of the tree to the one of the folder containing the file if the file is not under the current root directory
    -- only relevant when `update_focused_file.enable` is true
    update_cwd  = false,
    -- list of buffer names / filetypes that will not update the cwd if the file isn't found under the current root directory
    -- only relevant when `update_focused_file.update_cwd` is true and `update_focused_file.enable` is true
    ignore_list = {}
  },
  -- configuration options for the system open command (`s` in the tree by default)
  system_open = {
    -- the command to run this, leaving nil should work in most cases
    cmd  = nil,
    -- the command arguments as a list
    args = {}
  },

  view = {
    -- width of the window, can be either a number (columns) or a string in `%`
    width = 30,
    -- side of the tree, can be one of 'left' | 'right' | 'top' | 'bottom'
    side = 'left',
    mappings = {
      -- custom only false will merge the list with the default mappings
      -- if true, it will only use your list to set the mappings
      custom_only = false,
      -- list of mappings to set on the tree manually
      list = {}
    }
  },

  actions = {
    open_file = {
      quit_on_open = true,
      resize_window = false,
      window_picker = {
        enable = true,
        exclude = {
	        filetype = {'packer', 'qf', "diff", "fugitive", "fugitiveblame"},
	        buftype = {'terminal', "nofile", "help"}
        }
      }
    }
  },

  renderer = {
    root_folder_modifier = ':~',
    group_empty = true,
    add_trailing = true,
    highlight_git = true,
    highlight_opened_files = "all",
    special_files = {"Makefile", "MAKEFILE", "Cargo.toml", "README.md", "readme.md"},
    indent_markers = {
      enable = true
    },
    icons = {
      symlink_arrow = ' >> ',
      padding = ' ',
      show = {
	      git = true,
	      folder = true,
	      file = true,
	      folder_arrow = true
      },
      glyphs = {
        default = "",
        symlink = "",
        git = {
          unstaged = "✗",
          staged = "✓",
          unmerged = "",
          renamed = "➜",
          untracked = "★",
          deleted = "",
          ignored = "◌"
          },
        folder = {
          arrow_open = "",
          arrow_closed = "",
          default = "",
          open = "",
          empty = "",
          empty_open = "",
          symlink = "",
          symlink_open = "",
        }
      }
    }
  }

}
