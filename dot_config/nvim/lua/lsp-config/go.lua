-- function OrgImports(wait_ms)
--   local params = vim.lsp.util.make_range_params()
--   params.context = {only = {"source.organizeImports"}}
--   local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, wait_ms)
--   for _, res in pairs(result or {}) do
--     for _, r in pairs(res.result or {}) do
--       if r.edit then
--         vim.lsp.util.apply_workspace_edit(r.edit)
--       else
--         vim.lsp.buf.execute_command(r.command)
--       end
--     end
--   end
-- end

-- function Goimports(timeout_ms)
--     local context = { source = { organizeImports = true } }
--     vim.validate { context = { context, "t", true } }

--     local params = vim.lsp.util.make_range_params()
--     params.context = context

--     -- See the implementation of the textDocument/codeAction callback
--     -- (lua/vim/lsp/handler.lua) for how to do this properly.
--     local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, timeout_ms)
--     if not result or next(result) == nil then return end
--     local actions = result[1].result
--     if not actions then return end
--     local action = actions[1]

--     -- textDocument/codeAction can return either Command[] or CodeAction[]. If it
--     -- is a CodeAction, it can have either an edit, a command or both. Edits
--     -- should be executed first.
--     if action.edit or type(action.command) == "table" then
--       if action.edit then
--         print(action.edit)
--         vim.lsp.util.apply_workspace_edit(action.edit, "")
--       end
--       if type(action.command) == "table" then
--         vim.lsp.buf.execute_command(action.command)
--       end
--     else
--       vim.lsp.buf.execute_command(action)
--     end
-- end


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


local base_conf = require('lsp-config.base')

require 'lspconfig'.gopls.setup{
	on_attach = function (client, bufnr)
    require('lsp_signature').on_attach({
      bind = true, -- This is mandatory, otherwise border config won't get registered.
      handler_opts = {
        border = "rounded"
      }
    }, bufnr)

    local ls = require('luasnip')
    local fmt = require("luasnip.extras.fmt").fmt
    local i = ls.insert_node
    local c = ls.choice_node
    local sn = ls.snippet_node
    local t = ls.text_node
    -- local s = ls.snippet
    -- local d = ls.dynamic_node
    -- local extras = require("luasnip.extras")
    -- local isn = ls.indent_snippet_node
    -- local f = ls.function_node
    -- local r = ls.restore_node
    -- local events = require("luasnip.util.events")
    -- local ai = require("luasnip.nodes.absolute_indexer")
    -- local l = extras.lambda
    -- local rep = extras.rep
    -- local p = extras.partial
    -- local m = extras.match
    -- local n = extras.nonempty
    -- local dl = extras.dynamic_lambda
    -- local fmta = require("luasnip.extras.fmt").fmta
    -- local conds = require("luasnip.extras.expand_conditions")
    -- local postfix = require("luasnip.extras.postfix").postfix
    -- local types = require("luasnip.util.types")
    -- local parse = require("luasnip.util.parser").parse_snippet
    ls.cleanup()

    ls.add_snippets("go", {
      ls.snippet(
        {
          trig = "func",
          dscr = "Generate a Golang function",
        },
        fmt([[
            func <funcName> (<funcParams>) {
              <body>
            }
          ]],
          {
            funcName = i(1, "funcName"),
            funcParams = i(2, "funcParams"),
            body = i(0, 'panic("implements me!")'),
          },
          {
            delimiters = "<>",
          }
        ),
        {
          show_condition = function (line)
            -- TODO add code to verify if we're in the package scope.
            print(line)
            return true
          end
        }
      ),
      ls.snippet(
        {
          trig = "st",
          dscr = "Generate a Golang type",
        },
        fmt([[
            type <typeName> <type>
          ]],
          {
            typeName = i(1, "typeName"),
            type = c(2,
              {
                sn(1, { t{ "struct {", "" }, i(1, "body"), t{ "", "}" } }),
                i(2, "type"),
              }
            )
          },
          {
            delimiters = "<>",
          }
        )
      ),
      ls.snippet(
        {
          trig = "test",
          dscr = "Test function",
        },
        fmt([[
            func Test<testName>(t *testing.T) {
              <body>
            }
          ]],
          {
            testName = i(1, "testName"),
            body = i(0, "body"),
          },
          {
            delimiters = "<>",
          }
        )
      ),
      ls.snippet(
        {
          trig = "tr",
          dscr = "t.Run(XYZ, func(t *testintg.T){ ... })",
        },
        fmt([[
            t.Run("<testName>", func(t *testing.T){
              <body>
            })
          ]],
          {
            testName = i(1, "testName"),
            body = i(0, "body"),
          },
          {
            delimiters = "<>",
          }
        )
      ),
      ls.snippet(
        {
          trig = "interface",
          dscr = "type SomeInterface interface { ... }",
        },
        fmt([[
            type <interfaceName> interface {
              <methods>
            }
          ]],
          {
            interfaceName = i(1, "interfaceName"),
            methods = i(0, "methods"),
          },
          {
            delimiters = "<>",
          }
        )
      ),
      ls.snippet(
        {
          trig = "meth",
          dscr = "func (self Type) Method(...) [error] { ... }",
        },
        fmt([[
          func (<receiver> <type>) <name>(<params>) <returns> {
            <body>
          }
          ]],
          {
            receiver = i(1, "receiver"),
            type = i(0, "type"),
            name = i(0, "name"),
            params = i(0, "params"),
            returns = i(0, "returns"),
            body = i(0, "body"),
          },
          {
            delimiters = "<>",
          }
        )
      )
    })
    local s = ls.snippet
    local d = ls.dynamic_node
    local get_node_text = vim.treesitter.get_node_text
    local ts_utils = require "nvim-treesitter.ts_utils"
-- local ts_locals = require "nvim-treesitter.locals"

    ls.add_snippets("go", {
      s(
        "list_func",
        {
          t "variable_name.",
          d(1, function(_, _)
            local cursor_node = ts_utils.get_node_at_cursor()
            local query = vim.treesitter.query.parse(
              "go",
              [[
                [
                  (slice_type)
                  (array_type)
                  (map_type)
                ]
              ]]
            )
            for _, node in query:iter_captures(cursor_node:parent(), 0) do
              if node:type() == "slice_type" or node:type() == "array_type" or node:type() == "map_type" then
                return t "len(" .. get_node_text(node, 0) .. ")"
              end
            end
            return ""
          end, {}),
        }
      ),
    })

	  base_conf.on_attach(client, bufnr)
	end,
	capabilities = base_conf.capabilities,
  cmd = {'gopls'},
	settings = {
	  gopls = {
		  experimentalPostfixCompletions = true,
      gofumpt = true,
		  analyses = {
		    unusedparams = true,
		    shadow = true,
        nilness = true,
        unusedvariable = true,
		  },
      -- hoverKind = "Structured",
      -- linksInHover = false,
      -- hints = {
      --   assignVariableTypes = true,
      --   compositeLiteralFields = true,
      --   compositeLiteralTypes = true,
      --   functionTypeParameters = true,
      --   parameterNames = true,
      --   rangeVariableTypes = true,
      -- },
		  staticcheck = true,
		},
	},
}
