local nvim_lsp = require 'lspconfig'
local base_conf = require('lsp-config.base')

vim.api.nvim_create_autocmd("BufWritePre", { pattern = '*.ts', command = 'lua vim.lsp.buf.format { async = true }'})

nvim_lsp.tsserver.setup{
  on_attach = function (client, bufnr)
    -- TODO: add here the extra code (snippets, etc)

    -- Wrap the base_conf.on_attach
    base_conf.on_attach(client, bufnr)
  end,
  capabilities = base_conf.capabilities,
  cmd = { "typescript-language-server", "--stdio" },
}
