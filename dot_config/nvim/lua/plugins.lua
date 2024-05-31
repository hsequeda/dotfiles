-- NOTE to remove 'noice' notification
vim.opt.termguicolors = true

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  {
    "vhyrro/luarocks.nvim",
    priority = 1000,
    config = true,
  },
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v2.x",
		lazy = false,
		event = "VeryLazy",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"kyazdani42/nvim-web-devicons",
			"MunifTanjim/nui.nvim"
		},
		config = function()
			require("config.neo-tree")
		end
	},
  {
    'simrat39/symbols-outline.nvim',
    config = function ()
      require('config.symbols-outline')
    end
  },

	-- LSP
	{
	 	"williamboman/mason.nvim",
		config = function()
			require("config.mason")
		end
	},
	{
		"williamboman/mason-lspconfig",
		config = function()
			require("config.lsp.mason-lspconfig")
		end
	},
	{
		"neovim/nvim-lspconfig",
		config = function()
      require('config.lsp.go')
      require('config.lsp.common')
      require('config.lsp.rust')
      require('config.lsp.tsserver')
      require('config.lsp.clangd')
      require('config.lsp.graphql')
      require('config.lsp.html')
      require('config.lsp.css')
      require('config.lsp.zig')
		end
	},
	{
		"lvimuser/lsp-inlayhints.nvim",
		config = function ()
			require("lsp-inlayhints").setup({})
			vim.api.nvim_create_augroup("LspAttach_inlayhints", {})
			vim.api.nvim_create_autocmd("LspAttach", {
			  group = "LspAttach_inlayhints",
			  callback = function(args)
			    if not (args.data and args.data.client_id) then
			      return
			    end
			    local bufnr = args.buf
			    local client = vim.lsp.get_client_by_id(args.data.client_id)
			    require("lsp-inlayhints").on_attach(client, bufnr)
			  end,
			})
		end
	},
  {
    "hrsh7th/nvim-cmp",
    config = function()
      require("config.nvim-cmp")
    end,
    dependencies = {
      {
        "L3MON4D3/LuaSnip",
        event = "VeryLazy",
        version = "v2.*",
        build = "make install_jsregexp",
        config = function ()
          require('config.luasnip')
        end
      },
      {
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-buffer",
        "saadparwaiz1/cmp_luasnip",
        {
          "zbirenbaum/copilot-cmp",
          config = function ()
            require('copilot_cmp').setup()
          end
        },
        "onsails/lspkind-nvim",
      },
    }
  },
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
		config = function ()
			require('copilot').setup({
				suggestion = { enabled = false },
				panel = { enabled = false },
			})
		end
  },

  -- icons
  "kyazdani42/nvim-web-devicons",

  -- nvim-treesitter
  "nvim-treesitter/nvim-treesitter-textobjects",
  "nvim-treesitter/nvim-tree-docs",
  {
    "nvim-treesitter/nvim-treesitter",
    lazy = true,
    config = function()
      require("config.nvim-treesitter")
    end
  },
  {
    "nvim-treesitter/nvim-treesitter-context",
    config = function ()
      require("config.nvim-treesitter-context")
    end
  },

  -- Theme
  {
    "EdenEast/nightfox.nvim",
    config = function ()
      require('config.nightfox')
    end
  },
  {"rebelot/kanagawa.nvim"},
  {"tanvirtin/monokai.nvim"},


  -- fuzzy finder
  "nvim-lua/popup.nvim",
  "nvim-lua/plenary.nvim",
  {
    "nvim-telescope/telescope.nvim",
    config = function ()
      require("config.telescope-nvim")
    end
  },
  {
    "nvim-telescope/telescope-ui-select.nvim",
    config = function ()
      require("config.telescope-ui-select")
    end
  },
  "nvim-telescope/telescope-symbols.nvim",
  {
    "nvim-telescope/telescope-media-files.nvim",
    config = function ()
      require("config.telescope-media-files")
    end
  },
  "nvim-telescope/telescope-dap.nvim",

  -- documentation
  {
    "folke/todo-comments.nvim",
    config = function ()
      require("config.todo-comments")
    end
  },
  {
    "danymat/neogen",
    config = function ()
      require('neogen').setup {}
    end,
    dependencies = {
      "nvim-treesitter/nvim-treesitter"
    }
  },


  {
    "m4xshen/autoclose.nvim",
    config = function ()
      require("config.autoclose")
    end
  },
  {
    "kylechui/nvim-surround",
    config = function ()
      require("nvim-surround").setup({})
    end
  },

  -- git
  {
    "kdheepak/lazygit.nvim",
    config = function ()
      require("config.lazygit")
    end

  },
  {
    "lewis6991/gitsigns.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("config.gitsigns")
    end,
  },

  {
    'nanozuki/tabby.nvim',
    dependencies = 'nvim-tree/nvim-web-devicons',
    event = 'VimEnter',
    config = function ()
      vim.o.showtabline = 2
      require('tabby.tabline').use_preset('active_wins_at_tail', {
        theme = {
          fill = 'TabLineFill',       -- tabline background
          head = 'TabLine',           -- head element highlight
          current_tab = 'TabLineSel', -- current tab label highlight
          tab = 'TabLine',            -- other tab label highlight
          win = 'TabLine',            -- window highlight
          tail = 'TabLine',           -- tail element highlight
        },
        nerdfont = true,              -- whether use nerdfont
        lualine_theme = nil,          -- lualine theme name
        tab_name = {
          name_fallback = function(tabid)
            return tabid
          end,
        },
        buf_name = {
          mode = 'unique'
        },
      })
    end
  },
  -- {
  --   'akinsho/bufferline.nvim',
  --   config = function ()
  --     require("bufferline").setup {
  --       options = {
  --         mode = 'buffers',
  --         diagnostics = "nvim_lsp",
  --         diagnostics_indicator = function(count, level, _, _)
  --           local icon = level:match("error") and " " or " "
  --           return " " .. icon .. count
  --         end,
  --         numbers = 'buffer_id',
  --         separator_style = 'slant',
  --         highlights = {
  --           buffer_selected = {
  --             fg = '#663322',
  --             italic = true,
  --           },
  --         },
  --         hover = {
  --           enable = true,
  --           delay = 200,
  --           reveal = {'close'}
  --         }
  --       }
  --     }
  --   end
  -- },

	{
		"folke/neodev.nvim",
		config = function ()
			require("neodev").setup({
				library = {
					types = true,
				}
			})
		end
	},

   -- T-Pope
  "tpope/vim-commentary",
  "tpope/vim-abolish",

  -- line
  {
    "hoob3rt/lualine.nvim",
    config = function ()
      require('config.lualine')
    end
  },

	-- notification
	{
        "folke/noice.nvim",
        config = function()
          require('config.noice')
        end,
        dependencies = {
          "MunifTanjim/nui.nvim",
          "rcarriga/nvim-notify",
        },
  },
  {
        "rcarriga/nvim-notify",
        config = function()
            require("notify").setup({
                background_colour = "#000000"
            })
        end
  },
  {
    "folke/trouble.nvim",
    config = function ()
      require('config.trouble')
    end,
    dependencies = { "kyazdani42/nvim-web-devicons" },
  },

  -- debug
  {
    "mfussenegger/nvim-dap",
    config = function ()
      require("config.dbg.init")
    end
  },
  {
		"leoluz/nvim-dap-go",
		ft = "go",
		dependencies = "mfussenegger/nvim-dap",
	},
	{
		"rcarriga/nvim-dap-ui",
    dependencies = {
      "nvim-neotest/nvim-nio",
      "mfussenegger/nvim-dap"
    },
	},
  {
    "theHamsta/nvim-dap-virtual-text",
  },
  -- Golang
  {
    -- "hsequeda/gopher.nvim",
    dir = "~/projects/lua/gopher.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    config = function ()
      require("gopher").setup({
        commands = {
          go = "go",
          gomodifytags = "gomodifytags",
          gotests = "~/go/bin/gotests",
          impl = "impl",
          iferr = "iferr",
        }
      })
    end
  },
  require('config.which-key'),
  require('config.rest-nvim'),

  -- {
 -- "jackMort/ChatGPT.nvim",
  --   event = "VeryLazy",
  --   config = function()
  --     require("chatgpt").setup()
  --   end,
  --   dependencies = {
  --     "MunifTanjim/nui.nvim",
  --     "nvim-lua/plenary.nvim",
  --     "folke/trouble.nvim",
  --     "nvim-telescope/telescope.nvim"
  --   }
  -- },
  {
    "doctorfree/cheatsheet.nvim",
		config = function ()
			require("cheatsheet").setup({})
		end,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-lua/popup.nvim",
    },
  }
})
