return {
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "antoinemadec/FixCursorHold.nvim",
      "nvim-treesitter/nvim-treesitter",
      "nvim-neotest/neotest-plenary",
      "nvim-neotest/neotest-jest",
      "nvim-neotest/nvim-nio",
    },
    config = function()
      local neotest = require("neotest")
      neotest.setup({
        adapters = {
          require("neotest-jest")({
            jestCommand = "yarn test",
            jestConfigFile = "custom.jest.config.json",
            env = { CI = true },
            cwd = function()
              return vim.fn.getcwd()
            end
          })
        }
      })

      vim.keymap.set('n', '<leader>t', function()
        neotest.run.run()
      end)
    end,
  },
}
