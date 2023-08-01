local base_conf = require('config.lsp.base')
require'lspconfig'.html.setup{
  on_attach = base_conf.on_attach,
  capabilities = base_conf.capabilities,
}
