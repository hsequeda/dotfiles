local nvim_lsp = require 'lspconfig'
local base_conf = require('config.lsp.base')


--- Function to format Typescript files using 'prettier' if exist, if not it will
--- use the lsp formatter.
function Format_with_prettier_or_fallback()
  -- Verify if prettier is installed
  local prettier_installed = os.execute("prettier --version > /dev/null 2>&1")

  -- Define the current buffer
  local bufnr = vim.api.nvim_get_current_buf()

  if prettier_installed then
    -- Format with prettier
    vim.api.nvim_command('%!prettier --stdin-filepath ' .. vim.api.nvim_buf_get_name(bufnr))
  else
    -- Fallback to lsp formatter
    vim.lsp.buf.formatting()
  end
end

vim.api.nvim_create_autocmd("BufWritePre", { pattern = '*.ts', command = 'lua Format_with_prettier_or_fallback()'})

nvim_lsp.tsserver.setup{
  on_attach = function (client, bufnr)
    -- TODO: add here the extra code (snippets, etc)

    -- Wrap the base_conf.on_attach
    base_conf.on_attach(client, bufnr)
  end,
  capabilities = base_conf.capabilities,
  cmd = { "typescript-language-server", "--stdio" },
  settings = {
    typescript = {
      inlayHints = {
        includeInlayParameterNameHints = 'all',
        includeInlayParameterNameHintsWhenArgumentMatchesName = false,
        includeInlayFunctionParameterTypeHints = true,
        includeInlayVariableTypeHints = true,
        includeInlayVariableTypeHintsWhenTypeMatchesName = false,
        includeInlayPropertyDeclarationTypeHints = true,
        includeInlayFunctionLikeReturnTypeHints = true,
        includeInlayEnumMemberValueHints = true,
      }
    },
    javascript = {
      inlayHints = {
        includeInlayParameterNameHints = 'all',
        includeInlayParameterNameHintsWhenArgumentMatchesName = false,
        includeInlayFunctionParameterTypeHints = true,
        includeInlayVariableTypeHints = true,
        includeInlayVariableTypeHintsWhenTypeMatchesName = false,
        includeInlayPropertyDeclarationTypeHints = true,
        includeInlayFunctionLikeReturnTypeHints = true,
        includeInlayEnumMemberValueHints = true,
      }
    }
  }
}
