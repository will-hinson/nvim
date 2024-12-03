codewindow_config = {
  -- NOTE: disabled because we rolled our own implementation below
  --auto_enable = true,
  exclude_filetypes = {"help", "neo-tree"},
  minimap_width = 8,
}

-- global variable to represent whether or not the codewindow has been toggled off or closed
codewindow_closed = false

-- roll our own auto_enable autocmd. auto_enable allows only inclusions, not exclusions
vim.api.nvim_create_autocmd({ 'BufEnter', 'WinEnter' }, {
  callback = function()
    if codewindow_closed then
      return
    end

    local codewindow = require('codewindow')
    local filetype = vim.bo.filetype
    local should_open = false

    found_exclusion = false
    for _, v in ipairs(codewindow_config.exclude_filetypes) do
      if v == filetype then
        found_exclusion = true
      end
    end
    should_open = not found_exclusion
    
    if codewindow_config.max_lines then
      if api.nvim_buf_line_count(api.nvim_get_current_buf()) > codewindow_config.max_lines then
        should_open = false
      end
    end

    -- always disable in terminals
    if vim.bo.buftype == 'terminal' then --and not config.active_in_terminals then
      return
    end

    if should_open then
      vim.schedule(codewindow.open_minimap)
    else
      vim.schedule(codewindow.close_minimap)
    end
  end
})

return {
  "gorbit99/codewindow.nvim",
  config = function()
    local codewindow = require("codewindow")
    codewindow.setup(codewindow_config)

    -- apply the default keybindings. we do this so we can override the definitions
    vim.keymap.set('n', '<leader>mo', function()
        codewindow.open_minimap()
        codewindow_closed = false
      end,
      { desc = 'Open minimap' }
    )
    vim.keymap.set('n', '<leader>mf', function() codewindow.toggle_focus() end, { desc = 'Toggle minimap focus' })
    vim.keymap.set('n', '<leader>mc', function()
        codewindow.close_minimap()
        codewindow_closed = true
      end,
      { desc = 'Close minimap' }
    )
    vim.keymap.set('n', '<leader>mm', function()
        codewindow.toggle_minimap()
        codewindow_closed = not codewindow_closed
      end,
      { desc = 'Toggle minimap' }
    )
  end
}

