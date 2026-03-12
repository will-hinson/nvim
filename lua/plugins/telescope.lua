return {
  "nvim-telescope/telescope.nvim",
  opts = function(_, opts)
    local actions = require("telescope.actions")

    opts.defaults = opts.defaults or {}
    opts.defaults.mappings = opts.defaults.mappings or {}

    -- map <esc> to close the telescope window in insert mode
    opts.defaults.mappings.i = {["<esc>"] = actions.close}

    -- map all paths to posix
    opts.defaults.path_display = function(_, path)
      path = path:gsub("\\", "/")

      local filename = vim.fs.basename(path)
      local directory = vim.fs.dirname(path)

      return filename .. "/" .. directory

      -- this renders the filename/dir as columns. disabled for now
      --local filename_padded = string.format("%-30s", filename)
      --return filename_padded .. " " .. directory
    end

    return opts
  end,
}
