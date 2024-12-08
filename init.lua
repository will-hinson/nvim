-- This file simply bootstraps the installation of Lazy.nvim and then calls other files for execution
-- This file doesn't necessarily need to be touched, BE CAUTIOUS editing this file and proceed at your own risk.
local lazypath = vim.env.LAZY or vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
if not (vim.env.LAZY or (vim.uv or vim.loop).fs_stat(lazypath)) then
  -- stylua: ignore
  vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath })
end
vim.opt.rtp:prepend(lazypath)

-- validate that lazy is available
if not pcall(require, "lazy") then
  -- stylua: ignore
  vim.api.nvim_echo({ { ("Unable to load lazy from: %s\n"):format(lazypath), "ErrorMsg" }, { "Press any key to exit...", "MoreMsg" } }, true, {})
  vim.fn.getchar()
  vim.cmd.quit()
end

require "lazy_setup"
require "polish"

vim.opt.relativenumber = false

vim.g.nord_disable_background = true
vim.cmd[[colorscheme nord]]
vim.cmd[[highlight Normal guibg=#1a1d23]]
vim.cmd[[highlight WinBar cterm=bold gui=bold guifg=NvimLightGrey4 guibg=#1a1d23]]
vim.cmd[[highlight WinBarNC cterm=bold guifg=NvimLightGrey4 guibg=#16181d]]

require('lualine').setup {
  icons_enabled = true,
  theme = 'nord'
}

--[[require('neo-tree').setup(
  {
    default_component_configs = {
      git_status = {
        symbols = {
          unstaged = "U",
          staged = "S",
          unmerged = "UM",
          renamed = "R",
          deleted = "D",
          untracked = "UT",
          ignored = "I",
        }
      }
    }
  }
)]]
