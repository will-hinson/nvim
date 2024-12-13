return {
  { -- override nvim-cmp plugin
    "hrsh7th/nvim-cmp",
    -- override the options table that is used in the `require("cmp").setup()` call
    opts = function(_, opts)
      -- opts parameter is the default options table
      -- the function is lazy loaded so cmp is able to be required
      local cmp = require("cmp")
      local copilot_suggestion = require("copilot.suggestion")
      -- modify the mapping part of the table
      opts.mapping["<Tab>"] = cmp.mapping({
        i = function(fallback)
          if cmp.visible() then --and cmp.get_active_entry() then
            cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false })
          elseif copilot_suggestion.is_visible() then
            -- ensure that there is an active file encoding
            if vim.bo.fileencoding._value == "" or vim.bo.fileencoding == "" then
              vim.cmd[[set fileencoding=utf-8]]
            end
            
            copilot_suggestion.accept()
          else
            fallback()
          end
        end,
        s = cmp.mapping.confirm({ select = true }),
        c = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true }),
      })
      opts.mapping["<Esc>"] = cmp.mapping({
        i = cmp.mapping.abort(),
        c = cmp.mapping.close(),
      })
      opts.completion = {
        completeopt = 'menu,menuone,noinsert'
      }
    end,
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    ---@type neo-tree.nvim
    opts = { -- extend the plugin options
      filesystem = {
        filtered_items = {
          visible = false, -- hide filtered items on open
          hide_gitignored = false,
          hide_dotfiles = false,
          --[[hide_by_name = {
            ".github",
            ".gitignore",
            "package-lock.json",
            ".changeset",
            ".prettierrc.json",
          },]]
          never_show = { ".git" },
        },
      },
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
      },
      use_libuv_file_watcher = true,
    }
  },
  {
    "akinsho/toggleterm.nvim",
    opts = {
      shell = "psnologo.bat"
    }
  }
}
