local base = {}

base.on_attach = function(client, bufnr)
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  vim.api.nvim_buf_set_keymap(0, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', { noremap=true, silent=true } )
  vim.api.nvim_buf_set_keymap(0, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', { noremap=true, silent=true } )
  vim.api.nvim_buf_set_keymap(0, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', { noremap=true, silent=true } )
  vim.api.nvim_buf_set_keymap(0, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', { noremap=true, silent=true } )
  vim.api.nvim_buf_set_keymap(0, 'n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', { noremap=true, silent=true } )
  vim.api.nvim_buf_set_keymap(0, 'n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', { noremap=true, silent=true } )
  vim.api.nvim_buf_set_keymap(0, 'n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', { noremap=true, silent=true } )
  vim.api.nvim_buf_set_keymap(0, 'n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', { noremap=true, silent=true } )
  vim.api.nvim_buf_set_keymap(0, 'n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', { noremap=true, silent=true } )
  vim.api.nvim_buf_set_keymap(0, 'n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', { noremap=true, silent=true } )
  vim.api.nvim_buf_set_keymap(0, 'n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', { noremap=true, silent=true } )
  vim.api.nvim_buf_set_keymap(0, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', { noremap=true, silent=true } )
  vim.api.nvim_buf_set_keymap(0, 'n', '<space>e', '<cmd>lua vim.diagnostic.open_float()<CR>', { noremap=true, silent=true } )
  vim.api.nvim_buf_set_keymap(0, 'n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', { noremap=true, silent=true } )
  vim.api.nvim_buf_set_keymap(0, 'n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', { noremap=true, silent=true } )
  vim.api.nvim_buf_set_keymap(0, 'n', '<space>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', { noremap=true, silent=true } )
  vim.api.nvim_buf_set_keymap(0, 'n', '<space>f', '<cmd>lua vim.lsp.buf.format()<CR>', { noremap=true, silent=true } )

  -- Set autocommands conditional on server_capabilities
  if client.server_capabilities.document_highlight then
    vim.api.nvim_exec([[
      hi LspReferenceRead cterm=bold ctermbg=DarkMagenta guibg=LightYellow
      hi LspReferenceText cterm=bold ctermbg=DarkMagenta guibg=LightYellow
      hi LspReferenceWrite cterm=bold ctermbg=DarkMagenta guibg=LightYellow
      augroup lsp_document_highlight
        autocmd! * <buffer>
        autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
        autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
      augroup END
    ]], false)
  end
end

-- Add additional capabilities supported by nvim-cmp
base.capabilities = vim.lsp.protocol.make_client_capabilities()
base.capabilities.textDocument.completion.completionItem.documentationFormat = { 'markdown', 'plaintext' }
base.capabilities.textDocument.completion.completionItem.snippetSupport = true
base.capabilities.textDocument.completion.completionItem.preselectSupport = true
base.capabilities.textDocument.completion.completionItem.insertReplaceSupport = true
base.capabilities.textDocument.completion.completionItem.labelDetailsSupport = true
base.capabilities.textDocument.completion.completionItem.deprecatedSupport = true
base.capabilities.textDocument.completion.completionItem.commitCharactersSupport = true
base.capabilities.textDocument.completion.completionItem.tagSupport = { valueSet = { 1 } }
base.capabilities.textDocument.completion.completionItem.resolveSupport = {
  properties = {
    'documentation',
    'detail',
    'additionalTextEdits',
  },
}

return base
