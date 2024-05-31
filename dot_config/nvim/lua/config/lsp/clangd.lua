local base_conf = require('config.lsp.base')
require 'lspconfig'.clangd.setup{
  on_attach = function (client, bufnr)
    base_conf.on_attach(client, bufnr)
  end,
  capabilities = base_conf.capabilities,
  filetypes = { "c", "cpp", "objc", "objcpp", "cuda"}
}
