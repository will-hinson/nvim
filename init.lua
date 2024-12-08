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
vim.opt.fillchars = vim.opt.fillchars + 'diff:╱'

-- NOTE: this is the configuration for Nord
vim.g.nord_disable_background = true
vim.cmd[[colorscheme nord]]
vim.cmd[[highlight Normal guibg=#1a1d23]]
vim.cmd[[highlight WinBar cterm=bold gui=bold guifg=NvimLightGrey4 guibg=#1a1d23]]
vim.cmd[[highlight WinBarNC cterm=bold guifg=NvimLightGrey4 guibg=#16181d]]

local wilder = require('wilder')
wilder.setup({modes = {':', '/', '?'}})
wilder.set_option('renderer', wilder.popupmenu_renderer(
  wilder.popupmenu_border_theme({
    highlights = {
      border = 'Normal', -- highlight to use for the border
    },
    -- 'single', 'double', 'rounded' or 'solid'
    -- can also be a list of 8 characters, see :h wilder#popupmenu_border_theme() for more details
    border = 'rounded',
  })
))

--vim.opt.background = "dark" -- set this to dark or light
--vim.cmd("colorscheme oxocarbon")

require('lualine').setup {
  icons_enabled = true,
  theme = 'nord'
}

vim.keymap.set('n', '<F12>', vim.lsp.buf.definition, {})
vim.keymap.set('n', '<F4>', function() vim.cmd[[BufDel]] end, {})
vim.keymap.set('', '<C-b>', function()
    vim.cmd[[Neotree toggle]]
    vim.cmd[[wincmd p]]
  end,
  {}
)
vim.keymap.set('', '<C-M-b>', function() vim.cmd[[BlameToggle]] end, {})
vim.keymap.set('n', '<C-f>', function() vim.cmd[[Telescope current_buffer_fuzzy_find]] end, {})
vim.keymap.set('n', '<C-M-f>', function() vim.cmd[[Telescope live_grep]] end, {})
vim.keymap.set('n', '<C-g>', function() vim.cmd[[DiffviewOpen]] end, {})
vim.keymap.set('', '<C-`>', function() vim.cmd[[ToggleTerm horizontal split]] end, {})
vim.keymap.set('t', '<C-`>', function() vim.cmd[[ToggleTerm horizontal split]] end, {})
vim.keymap.set('', '<C-PageUp>', function() vim.cmd[[bp]] end, {})
vim.keymap.set('', '<C-PageDown>', function() vim.cmd[[b#]] end, {})
vim.keymap.set('n', '<C-a>', function() vim.api.nvim_feedkeys("ggVG", "m") end, {})
