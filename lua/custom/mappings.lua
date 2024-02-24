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
            "Close Debugger UI"
        },
    }
}

M.dap_python = {
    plugin = true,
    n = {
        ["<leader>dpr"] = {
            function()
                require('dap-python').test_method()
            end
        }
    }
}

return M
