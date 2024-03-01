local M = {}

M.dap = {
  plugin = true,
  n = {
    ["<leader>db"] = {
      "<cmd> DapToggleBreakpoint <CR>",
      "Add breakpoint at line",
    },
    ["<leader>dr"] = {
      "<cmd> DapContinue <CR>",
      "Start or continue the debugger",
    },
    ["<leader>do"] = {
      "<cmd> DapStepOver <CR>",
      "Step Over",
    },
    ["<leader>dot"] = {
      "<cmd> DapStepOut <CR>",
      "Step Out",
    },
    ["<leader>di"] = {
      "<cmd> DapStepInto <CR>",
      "Step Into",
    },
    ["<leader>dt"] = {
      "<cmd> DapTerminate <CR>",
      "Terminate Debugger Session",
    },
    ["<leader>dc"] = {
      ':lua require"dapui".close()<CR>',
      "Close Debugger UI",
    },
    ["<leader>dus"] = {
      function()
        local widgets = require "dap.ui.widgets"
        local sidebar = widgets.sidebar(widgets.scopes)
        sidebar.open()
      end,
      "Open debugging sidebar",
    },
  },
}

M.dap_python = {
  plugin = true,
  n = {
    ["<leader>dpr"] = {
      function()
        require("dap-python").test_method()
      end,
    },
  },
}

M.dap_go = {
  plugin = true,
  n = {
    ["<leader>dgt"] = {
      function()
        require("dap-go").debug_test()
      end,
      "Debug go test",
    },
    ["<leader>dgl"] = {
      function()
        require("dap-go").debug_last()
      end,
      "Debug last go test",
    },
  },
}

return M
