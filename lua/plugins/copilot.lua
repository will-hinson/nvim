return {
  "zbirenbaum/copilot.lua",
  cmd = "Copilot",
  event = "InsertEnter",
  config = function()
    require("copilot").setup({
      suggestion = {
        auto_trigger = true,
        keymap = {
          --accept = "<Tab>",
          dismiss = "<Esc>"
        }
      }
    })

    vim.keymap.set("n", "<leader>se", function()
      vim.cmd("Copilot enable")
    end, { desc = "Copilot: Enable" })

    vim.keymap.set("n", "<leader>sd", function()
      vim.cmd("Copilot disable")
    end, { desc = "Copilot: Disable" })

    vim.keymap.set("n", "<leader>st", function()
      vim.cmd("Copilot toggle")
    end, { desc = "Copilot: Toggle"})
  end,
}
