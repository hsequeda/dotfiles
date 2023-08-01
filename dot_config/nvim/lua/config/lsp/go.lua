local base_conf = require('config.lsp.base')

require 'lspconfig'.gopls.setup{
	on_attach = function (client, bufnr)
	  base_conf.on_attach(client, bufnr)
	end,
	capabilities = base_conf.capabilities,
	settings = {
	  gopls = {
		  experimentalPostfixCompletions = true,
      usePlaceholders = true,
      completeUnimported = true,
      gofumpt = true,
      codelenses = {
        gc_details = false,
        generate = false,
        -- run_govulncheck = true,
      },
		  analyses = {
		    unusedparams = true,
		    shadow = true,
        nilness = true,
        unusedvariable = true,
		  },
      -- hoverKind = "Structured",
      linksInHover = false,
      hints = {
        assignVariableTypes = true,
        compositeLiteralFields = true,
        compositeLiteralTypes = true,
        functionTypeParameters = true,
        parameterNames = true,
        rangeVariableTypes = true,
      },
		  staticcheck = true,
		},
	},
}

vim.api.nvim_create_autocmd("BufWritePre", { pattern = '*.go', command = 'lua vim.lsp.buf.format { async = true }'})
vim.api.nvim_create_autocmd( 'FileType',
  {
    pattern = 'go',
    callback = function ()
      vim.api.nvim_buf_set_keymap(0, 'n', '<leader>gie', '<cmd>GoIfErr<CR>', { silent = true, nowait = true })
      vim.api.nvim_buf_set_keymap(0, 'n', '<leader>fs', '<cmd>GoFillStruct<CR>', { silent = true, nowait = true })
      vim.api.nvim_buf_set_keymap(0, 'n', '<leader>gr', '<cmd>GoGenReturn<CR>', { silent = true, nowait = true })
      vim.api.nvim_buf_set_keymap(0, 'n', '<leader>gc', '<cmd>GoCmt<CR>', { silent = true, nowait = true })
    end
  }
)
