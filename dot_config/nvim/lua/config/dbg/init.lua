local map = vim.api.nvim_set_keymap
local default_opts = { noremap = true, silent = true }

map('n', '<F6>', '<cmd> DapTerminate <CR>',default_opts)
map('n', '<F5>', '<cmd> DapContinue <CR>',default_opts)
map('n', '<F2>', '<cmd> DapStepInto <CR>',default_opts)
map('n', '<F3>', '<cmd> DapStepOver <CR>',default_opts)
map('n', '<F4>', '<cmd> DapStepOut <CR>',default_opts)
map('n', '<leader>db', '<cmd> DapToggleBreakpoint <CR>',default_opts)
map('n', '<leader>dB', '<cmd> lua require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: ")) <CR>',default_opts)
map('n', '<leader>dlp', '<cmd> lua require("dap").set_breakpoint(nil, nil, vim.fn.input("Log point message: ")) <CR>',default_opts)

require("nvim-dap-virtual-text").setup({
      enabled = true, -- enable this plugin (the default)
      enabled_commands = true, -- create commands DapVirtualTextEnable, DapVirtualTextDisable, DapVirtualTextToggle, (DapVirtualTextForceRefresh for refreshing when debug adapter did not notify its termination)
      highlight_changed_variables = true, -- highlight changed values with NvimDapVirtualTextChanged, else always NvimDapVirtualText
      highlight_new_as_changed = false, -- highlight new variables in the same way as changed variables (if highlight_changed_variables)
      show_stop_reason = true, -- show stop reason when stopped for exceptions
      commented = true, -- prefix virtual text with comment string
      only_first_definition = true, -- only show virtual text at first definition (if there are multiple)
      all_references = false, -- show virtual text on all all references of the variable (not only definitions)
      filter_references_pattern = "<module", -- filter references (not definitions) pattern when all_references is activated (Lua gmatch pattern, default filters out Python modules)
      -- experimental features:
      virt_text_pos = "eol", -- position of virtual text, see `:h nvim_buf_set_extmark()`
      all_frames = false, -- show virtual text for all stack frames not only current. Only works for debugpy on my machine.
      virt_lines = false, -- show virtual lines instead of virtual text (will flicker!)
      virt_text_win_col = nil -- position the virtual text at a fixed window column (starting from the first text column) ,
            -- e.g. 80 to position at column 80, see `:h nvim_buf_set_extmark()`      })
})

local get_test_regexp = function ()
  return coroutine.create(function(dap_run_co)
    local args = {"-test.run"}
    vim.ui.input({ prompt = "Args: " }, function(input)
      for _, value in ipairs(vim.split(input or "", " ")) do
        table.insert(args, value)
      end
      coroutine.resume(dap_run_co, args)
    end)
  end)
end

require("dap-go").setup({
  dap_configurations = {
    {
      type = "go",
      name = "Debug Test (-test.run ${regexp})",
      request = "launch",
      mode = "test",
      program = "${file}",
      args = get_test_regexp,
      buildFlags = "",
    },
    {
      type = "go",
      name = "Debug Test (-test.run ${regexp}) (go.mod)",
      request = "launch",
      mode = "test",
      program = "./${relativeFileDirname}",
      args = get_test_regexp,
      buildFlags = "",
    },
  }
})

require("dapui").setup()

local dap, dapui = require("dap"), require("dapui")
dap.listeners.after.event_initialized["dapui_config"] = function ()
  dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function ()
  dapui.close()
end

dap.listeners.before.event_exited["dapui_config"] = function ()
  dapui.close()
end
