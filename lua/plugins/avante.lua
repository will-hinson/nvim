return {
  "yetone/avante.nvim",
  build = vim.fn.has("win32") ~= 0
      and "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false"
      or "make",
  event = "VeryLazy",
  version = false,
  ---@module 'avante'
  ---@type avante.Config
  opts = {
    -- Switch the default provider to Copilot
    provider = "copilot",

    -- keep other providers if you want to switch later
    providers = {
      copilot = {
        endpoint = "https://api.githubcopilot.com",
        -- Copilot’s default model in Avante (you can change this later via :AvanteModels)
        model = "gpt-4o-2024-11-20",
        timeout = 30000,
        extra_request_body = {
          temperature = 0.75,
          max_tokens = 20480,
        },
      },

      -- optional: keep your existing ones to swap later
      -- claude = { ... },
      -- moonshot = { ... },
    },

    -- (optional) Don’t make Copilot your auto-suggestions engine unless you mean to.
    -- It can get expensive at high frequency; the Avante readme warns against it.
    -- auto_suggestions_provider = "claude",
  },

  dependencies = {
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    "hrsh7th/nvim-cmp",
    "nvim-tree/nvim-web-devicons",
    "echasnovski/mini.pick",
    "nvim-telescope/telescope.nvim",
    "ibhagwan/fzf-lua",
    "stevearc/dressing.nvim",
    "folke/snacks.nvim",
    "HakonHarnes/img-clip.nvim",
    { "MeanderingProgrammer/render-markdown.nvim", opts = { file_types = { "markdown", "Avante" } }, ft = { "markdown", "Avante" } },

    -- Needed so Avante can reuse Copilot auth
    "zbirenbaum/copilot.lua",
  },
}
