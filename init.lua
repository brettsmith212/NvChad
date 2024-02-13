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

-- Use Lua functions to replicate the Vimscript expressions
local function set_titlestring()
  local hostname = vim.loop.os_gethostname()
  local filepath = vim.fn.expand('%:p') -- gets the full path of the file in the buffer
  local filename = vim.fn.expand('%:t') -- gets the tail of the file path (just the file name)
  local last_modified = os.date('%Y-%m-%d %H:%M', vim.fn.getftime(vim.fn.expand('%')))

  -- Set the titlestring using the information gathered above
  -- You can modify the string to format it as you like
  vim.o.titlestring = filepath .. ' [last modified: ' .. last_modified .. ']'
end

-- Call the function to set the titlestring
set_titlestring()

-- Optionally, you can also set an autocommand to update the titlestring whenever you switch buffers or write to a file
vim.api.nvim_create_autocmd({"BufEnter", "BufWinEnter", "BufWritePost"}, {
  pattern = "*",
  callback = set_titlestring
})

