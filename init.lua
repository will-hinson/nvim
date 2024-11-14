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

-- bindings to open/close plugins and buffers
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

-- bindings related to text selection
vim.keymap.set('i', '<C-a>', function() vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<esc>ggVG", true, false, true), "n", false) end, {})
vim.keymap.set('n', '<C-a>', function() vim.api.nvim_feedkeys("ggVG", "m") end, {})
vim.keymap.set('n', '<C-left>', function() vim.api.nvim_feedkeys("ge", "m") end, {})
vim.keymap.set('n', '<C-right>', function() vim.api.nvim_feedkeys("e", "m") end, {})
vim.keymap.set('n', '<C-M-left>', function() vim.api.nvim_feedkeys("vB", "m") end, {})
vim.keymap.set('v', '<C-M-left>', function() vim.api.nvim_feedkeys("B", "m") end, {})
vim.keymap.set('n', '<C-M-right>', function() vim.api.nvim_feedkeys("vE", "m") end, {})
vim.keymap.set('v', '<C-M-right>', function() vim.api.nvim_feedkeys("E", "m") end, {})
vim.keymap.set('i', '<S-Home>', function() vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>v0", true, false, true), 'n', false) end, {})
vim.keymap.set('n', '<S-Home>', function() vim.api.nvim_feedkeys("v0", "m") end, {})
vim.keymap.set('i', '<S-Home>', function() vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>v$", true, false, true), 'n', false) end, {})
vim.keymap.set('n', '<S-End>', function() vim.api.nvim_feedkeys("v$", "m") end, {})
vim.keymap.set('i', '<S-Down>', function() vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>v<Down>", true, false, true), 'n', false) end, {})
vim.keymap.set('n', '<S-Down>', function() vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("v<Down>", true, false, true), 'n', false) end, {})
vim.keymap.set('v', '<S-Down>', function() vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Down>", true, false, true), 'n', false) end, {})
vim.keymap.set('i', '<S-Left>', function() vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>v<Left>", true, false, true), 'n', false) end, {})
vim.keymap.set('n', '<S-Left>', function() vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("v<Left>", true, false, true), 'n', false) end, {})
vim.keymap.set('v', '<S-Left>', function() vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Left>", true, false, true), 'n', false) end, {})
vim.keymap.set('i', '<S-Right>', function() vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>v<Right>", true, false, true), 'n', false) end, {})
vim.keymap.set('n', '<S-Right>', function() vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("v<Right>", true, false, true), 'n', false) end, {})
vim.keymap.set('v', '<S-Right>', function() vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Right>", true, false, true), 'n', false) end, {})
vim.keymap.set('i', '<S-Up>', function() vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>v<Up>", true, false, true), 'n', false) end, {})
vim.keymap.set('n', '<S-Up>', function() vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("v<Up>", true, false, true), 'n', false) end, {})
vim.keymap.set('v', '<S-Up>', function() vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Up>", true, false, true), 'n', false) end, {})

-- bindings related to text deletion
vim.keymap.set('v', '<Backspace>', function() vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Delete>", true, false, true), 'n', false) end, {})
vim.keymap.set('i', '<C-Backspace>', function() vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc><Right>dBi", true, false, true), 'n', false) end, {})
vim.keymap.set('n', '<C-Backspace>', function() vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("dB", true, false, true), 'n', false) end, {})
vim.keymap.set('i', '<C-Delete>', function() vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc><Right>dei", true, false, true), 'n', false) end, {})
vim.keymap.set('n', '<C-Delete>', function() vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("de", true, false, true), 'n', false) end, {})

-- bindings related to moving lines around
vim.keymap.set('i', '<M-Down>', function() vim.cmd[[silent! m +1]] end, {})
vim.keymap.set('n', '<M-Down>', function() vim.cmd[[silent! m +1]] end, {})
vim.keymap.set('i', '<M-Up>', function() vim.cmd[[silent! m -2]] end, {})
vim.keymap.set('n', '<M-Up>', function() vim.cmd[[silent! m -2]] end, {})

-- bindings related to the terminal
vim.keymap.set('t', '<C-Backspace>', function() vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-w>", true, false, true), 'n', false) end, {})
