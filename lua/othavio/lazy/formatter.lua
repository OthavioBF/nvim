return {
  {
    'stevearc/conform.nvim',
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      local conform = require("conform")

      conform.setup({
        formatters_by_ft = {
          lua = { "stylua" },

          python = { "isort", "black" },

          javascript = { "eslint_d", "prettier" },
          javascriptreact = { "eslint_d", "prettier" },
          typescript = { "eslint_d", "prettier" },
          typescriptreact = { "eslint_d", "prettier" },
        },
        format_after_save = {
          async = true,
          lsp_fallback = true,
        },
      })
    end,
  }
}
