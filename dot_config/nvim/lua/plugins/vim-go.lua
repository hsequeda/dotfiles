
local g = vim.g

-- disable all linters as that is taken care of by coc.nvim
g.go_diagnostics_enabled = 0
g.go_diagnostics_level = 0
g.go_metalinter_enabled = {}

g.go_doc_keywordprg_enabled = 0
g.go_auto_type_info = 1

-- don't jump to errors after metalinter is invoked
g.go_jump_to_error = 0

-- run go imports on file save
g.go_fmt_command = 'goimports'


-- automatically highlight variable your cursor is on
-- g.go_auto_sameids = 1

g.go_list_type = "quickfix"
g.go_highlight_types = 1
g.go_highlight_fields = 1
g.go_highlight_functions = 1
g.go_highlight_function_calls = 1
g.go_highlight_operators = 1
g.go_highlight_extra_types = 1
g.go_highlight_build_constraints = 1
g.go_highlight_generate_tags = 1
