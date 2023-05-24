
local base_conf = require('lsp-config.base')

require('lspconfig').rust_analyzer.setup({
    on_attach = base_conf.on_attach,
    capabilities = base_conf.capabilities,
    settings = {
        ["rust-analyzer"] = {
            assist = {
                importGranularity = "module",
                importPrefix = "self",
            },
            cargo = {
                loadOutDirsFromCheck = true
            },
            procMacro = {
                enable = true
            },
            diagnostics = {
              enable = true,
              disabled = {"unresolved-proc-macro", "macro-error"},
              enableExperimental = true,
          },
        }
    }
})

-- Rust Analizer <<
