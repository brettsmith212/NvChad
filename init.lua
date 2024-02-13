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
  local filepath = vim.fn.expand('%:p')
  local filename = vim.fn.expand('%:t')
  local last_modified = os.date('%Y-%m-%d %H:%M', vim.fn.getftime(vim.fn.expand('%')))

  vim.o.titlestring = filepath .. ' [last modified: ' .. last_modified .. ']'
end

set_titlestring()

-- Autocommand to update the titlestring whenever you switch buffers or write to a file
vim.api.nvim_create_autocmd({"BufEnter", "BufWinEnter", "BufWritePost"}, {
  pattern = "*",
  callback = set_titlestring
})

