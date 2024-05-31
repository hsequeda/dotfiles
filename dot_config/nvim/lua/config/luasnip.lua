local ls = require('luasnip')
ls.setup({
  update_events = {"InsertLeave", "TextChanged", "TextChangedI"}
})


local i = ls.insert_node
local c = ls.choice_node
local sn = ls.snippet_node
local t = ls.text_node
local fmt = require("luasnip.extras.fmt").fmt
local f = ls.function_node

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
        type = i(2, "type"),
        name = i(3, "name"),
        params = i(4, "params"),
        returns = i(5, "returns"),
        body = i(0, "body"),
      },
      {
        delimiters = "<>",
      }
    )
  ),
  ls.snippet(
    {
      trig = "aftrad_entity",
      dscr = "create a new aftrad entity",
    },

    fmt([[
      package entity

      import "github.com/uptrace/bun"

      type <> struct {
      	bun.BaseModel `bun:"table:<>,alias:<>"`
        id
        <>
      }
      ]],
      {
        i(1, "EntityName"),
        f(function (args) return args[1][1]:gsub('(%l)(%u)', '%1_%2'):lower() end, {1}, "table_name"),
        i(2, "table_alias"),
        i(0, "fields"),
      },
      {
        delimiters = "<>",
      }
    )
  ),
})

-- local get_node_text = vim.treesitter.get_node_text
-- local ts_utils = require "nvim-treesitter.ts_utils"
-- local ts_locals = require "nvim-treesitter.locals"

-- ls.add_snippets("go", {
--   s(
--     "list_func",
--     {
--       t "variable_name.",
--       d(1, function(_, _)
--         local cursor_node = ts_utils.get_node_at_cursor()
--         local query = vim.treesitter.query.parse(
--           "go",
--           [[
--             [
--               (slice_type)
--               (array_type)
--               (map_type)
--             ]
--           ]]
--         )
--         for _, node in query:iter_captures(cursor_node:parent(), 0) do
--           if node:type() == "slice_type" or node:type() == "array_type" or node:type() == "map_type" then
--             return t "len(" .. get_node_text(node, 0) .. ")"
--           end
--         end
--         return ""
--       end, {}),
--     }
--   ),
-- })
