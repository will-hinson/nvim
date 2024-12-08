return {
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
      }
    }
  }
}
