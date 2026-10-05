-- orinel nvim config

vim.g.start_time = vim.fn.reltime()

local source = debug.getinfo(1, "S").source
local init_file = source:match("^@(.+)$") or vim.fn.expand("<sfile>:p")
local config_root = vim.fn.fnamemodify(init_file, ":p:h")
vim.opt.runtimepath:prepend(config_root)
package.path = table.concat({
  config_root .. "/lua/?.lua",
  config_root .. "/lua/?/init.lua",
  package.path,
}, ";")

vim.g.mapleader = " "
vim.g.maplocalleader = " "

require("config.options")
require("config.keymaps")
require("config.input")
require("config.mode-colors")
require("config.vscode")

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", lazypath,
  })
end

vim.opt.rtp:prepend(lazypath)

require("lazy").setup({ { import = "plugins" } })
