local base_conf = require('config.lsp.base')

require 'lspconfig'.gopls.setup{
	on_attach = function (client, bufnr)
	  base_conf.on_attach(client, bufnr)
	end,
	capabilities = base_conf.capabilities,
	settings = {
	  gopls = {
      buildFlags = {"-tags=integration,database,server_as_network,server_as_super_user,server_as_publisher"},
      ["local"] = "github.com/msales/trk-platform-api",
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


function sort_import()
  local ok, tree = pcall(function ()
    return vim.treesitter.get_parser(0, 'go'):parse()[1]
  end)

  if not ok then
    print("failed to build tree")
    return
  end

  local ok, parsed_query = pcall(function()
    return vim.treesitter.query.parse('go', [[ (import_spec_list) @import_list ]])
  end)

  if not ok then
    print("failed to parse query")
    return
  end

  local current_module_pattern = vim.fn.system("go list -m")
  current_module_pattern = string.sub(current_module_pattern, 1, -2)
  local xx =vim.fn.system("go list -m all | awk '{print $1}'")
  local yy = {}
  for line in string.gmatch(xx, "([^\n]+)") do
    table.insert(yy, line)
  end


  print(xx)
  local std_lib, local_packages, external_packages = {}, {}, {}
  for _, import_list_node in parsed_query:iter_captures(tree:root(), 0, vim.fn.line('w0') - 1, vim.fn.line('w$')) do
    for node in import_list_node:iter_children() do
      if node:type() == "import_spec" then
        local node_text = vim.treesitter.get_node_text(node, 1)
        if string.find(node_text, current_module_pattern, 1, true) ~= nil then
          table.insert(local_packages, node_text)
        elseif string.find(node_text, external_module_pattern, 1, true) ~= nil then
          table.insert(external_packages, node_text)
        else
          table.insert(std_lib, node_text)
        end
      end
    end

    print("local packages: ", vim.inspect(local_packages))
    print("external packages: ", vim.inspect(external_packages))

  end
end

vim.api.nvim_create_autocmd("BufWritePre", { pattern = '*.go', command = 'lua vim.lsp.buf.format { async = true }'})
vim.api.nvim_create_autocmd("BufWritePre", { pattern = '*.go', callback = function (ev)


end})

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
