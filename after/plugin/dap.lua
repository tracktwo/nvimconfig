
local dap = require('dap')
local dapui = require('dapui')

vim.fn.sign_define('DapBreakpoint', {text='🛑', texthl='', linehl='', numhl=''})

dapui.setup()

dap.configurations.rust = {
  {
    type = 'rust',
    request = 'attach',
    name = 'Attach To Process'
  }
}

vim.keymap.set('n', '<F9>', dap.toggle_breakpoint, { desc = "DAP: Toggle [B]reakpoint" })
vim.keymap.set('n', '<F11>', dap.step_into, { desc = "[D]AP: Step [I]nto" })
vim.keymap.set('n', '<F10>', dap.step_over, { desc = "[D]AP: Step [O]ver" })
-- F23 == S-F11
vim.keymap.set('n', '<F23>', dap.step_out, { desc = "[D]AP: Step O[u]t" })
-- F22 == S-F10
vim.keymap.set('n', '<F22>', dap.run_to_cursor, { desc = "[D]AP: Run to [C]ursor" })
vim.keymap.set('n', '<F5>', dap.continue, { desc = "[D]AP: [G]o" })
-- F17 == S-F5
vim.keymap.set('n', '<F17>', dap.terminate, { desc = "[D]AP: Close" })

vim.keymap.set('n', '<leader>dU', dapui.toggle, { desc = "[D]AP: Toggle [U]I" })
vim.keymap.set('n', '<leader>dc', dap.focus_frame, { desc = "[D]AP: Fo[c]us Frame" })


-- UI Config

dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open({})
end
dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close({})
end
dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close({})
end

-- Language specific keymaps

-- Python
local dap_python = require('dap-python')
dap_python.setup()
dap_python.test_runner = 'pytest'
vim.keymap.set('n', '<leader>tm', dap_python.test_method, { desc = "DAP: [T]est [M]ethod" })
vim.keymap.set('n', '<leader>tc', dap_python.test_class, { desc = "DAP: [T]est [C]lass" })
