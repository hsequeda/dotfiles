-----------------------------------------------------------
-- Neovim LSP configuration file
-----------------------------------------------------------

-- Plugin: nvim-lspconfig
-- for language server setup see: https://github.com/neovim/nvim-lspconfig

local nvim_lsp = require 'lspconfig'
local utils = require 'lspconfig.util'
local base_conf = require('config.lsp.base')

local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

nvim_lsp.lua_ls.setup {
    on_attach = base_conf.on_attach,
    capabilities = base_conf.capabilities,
    settings = {
        Lua = {
            runtime = {
                -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                version = 'LuaJIT',
                -- Setup your lua path
                path = vim.split(package.path, ';')
            },
            diagnostics = {
                -- Get the language server to recognize the `vim` global
                globals = {'vim'}
            },
            workspace = {
                -- Make the server aware of Neovim runtime files
                library = {[vim.fn.expand('$VIMRUNTIME/lua')] = true, [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true}
            }
        }
    }
}

-- Omnisharp >>

local cs_group = vim.api.nvim_create_augroup("cs_group", {clear = true})
vim.api.nvim_create_autocmd("FileType", {
  pattern = "cs",
  group =  cs_group,
  callback = function()
    -- operation is do it by the lsp configuration
    -- vim.api.nvim_buf_set_keymap(0, 'n', 'K', ':OmniSharpDocumentation<CR>', { silent = true, nowait = true })
    -- vim.api.nvim_buf_set_keymap(0, 'n', '<leader>f', ':OmniSharpCodeFormat<CR>', { silent = true, nowait = true })
    -- vim.api.nvim_buf_set_keymap(0, 'n', 'gd', '<Plug>(omnisharp_go_to_definition)', { silent = true })
    -- vim.api.nvim_buf_set_keymap(0, 'n', '<leader>rn', ':OmniSharpRename<CR>', { silent = true, nowait = true })
  end,
})


nvim_lsp.omnisharp.setup{
  on_attach = base_conf.on_attach,
  capabilities = base_conf.capabilities,
  cmd = { omnisharp_bin = '/home/hsequeda_i3/software/omnisharp/run', "--languageserver", "--hostPID", tostring(vim.fn.getpid()) },
  root_dir = nvim_lsp.util.root_pattern("*.csproj", "*.sln"),
  ...
 }


-- Omnisharp <<


-- Yaml
nvim_lsp.yamlls.setup {
  on_attach = base_conf.on_attach,
  capabilities = base_conf.capabilities,
  settings = {
    yaml = {
      schemas = {
        ["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*",
        ["../path/relative/to/file.yml"] = "/.github/workflows/*",
        ["/path/from/root/of/project"] = "/.github/workflows/*",
      },
    },
  }
}

require'lspconfig'.docker_compose_language_service.setup{
  on_attach = base_conf.on_attach,
  capabilities = base_conf.capabilities,
  filetypes = {"yaml.docker-compose" },
  root_dir = utils.root_pattern("docker-compose.yaml", "docker-compose.yml", "compose.yaml", "compose.yml"),
  single_file_support = true,
}

-- Tailwincss
-- nvim_lsp.tailwindcss.setup{}



nvim_lsp.pyright.setup{
  on_attach = base_conf.on_attach,
  capabilities = base_conf.capabilities,
  cmd = {"pyright-langserver", "--stdio"},
  filetype = {  "python" },
  settings = {
    python = {
      analysis = {
        autoSearchPaths = true,
        diagnosticMode = "workspace",
        useLibraryCodeForTypes = true
      }
    }
  }
}

nvim_lsp.bufls.setup{}
