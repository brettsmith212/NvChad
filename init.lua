require "core"

local custom_init_path = vim.api.nvim_get_runtime_file("lua/custom/init.lua", false)[1]

if custom_init_path then
  dofile(custom_init_path)
end

require("core.utils").load_mappings()

local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

-- bootstrap lazy.nvim!
if not vim.loop.fs_stat(lazypath) then
  require("core.bootstrap").gen_chadrc_template()
  require("core.bootstrap").lazy(lazypath)
end

dofile(vim.g.base46_cache .. "defaults")
vim.opt.rtp:prepend(lazypath)
require "plugins"

-- Enable setting the window title
vim.o.title = true

local function set_titlestring()
  local hostname = vim.loop.os_gethostname()
  local filepath = vim.fn.expand "%:p"
  local filename = vim.fn.expand "%:t"
  local last_modified = os.date("%Y-%m-%d %H:%M", vim.fn.getftime(vim.fn.expand "%"))

  vim.o.titlestring = filepath .. " [last modified: " .. last_modified .. "]"
end

set_titlestring()

-- Autocommand to update the titlestring whenever you switch buffers or write to a file
vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter", "BufWritePost" }, {
  pattern = "*",
  callback = set_titlestring,
})

-------------------- nvterm custom config ----------------------
local nvterm = require "nvterm.terminal"

_G.toggle_terminal = function()
  local current_buf = vim.api.nvim_get_current_buf()
  local buf_type = vim.bo[current_buf].buftype

  if buf_type == "terminal" then
    vim.cmd "stopinsert"
    vim.cmd "hide" -- this hides only and keeps history
    -- vim.cmd "bd!" -- this will close the window
  else
    nvterm.toggle "horizontal"
  end
end

vim.keymap.set("n", "<leader>h", _G.toggle_terminal, { noremap = true, silent = true })

vim.api.nvim_create_autocmd("TermOpen", {
  pattern = "*",
  callback = function()
    vim.api.nvim_buf_set_keymap(
      0,
      "t",
      "<leader>h",
      [[<C-/><C-n><cmd>lua _G.toggle_terminal()<CR>]],
      { noremap = true, silent = true }
    )
  end,
})

function _G.toggle_term()
  toggle_terminal()
end
