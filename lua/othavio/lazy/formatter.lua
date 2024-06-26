return {
  {
    'stevearc/conform.nvim',
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      local conform = require("conform")

      conform.setup({
        formatters_by_ft = {
          lua = { "stylua" },
          -- Conform will run multiple formatters sequentially
          python = { "isort", "black" },
          -- Use a sub-list to run only the first available formatter
          javascript = { "prettier" },
          javascriptreact = { "prettier" },
          typescript = { "prettier" },
          typescriptreact = { "prettier" },
        },
        format_on_save = {
          -- These options will be passed to conform.format()
          async = false,
          timeout_ms = 100,
          lsp_fallback = true,
        },
      })

      conform.format({
        async = false,
        timeout_ms = 100,
        lsp_fallback = true,
      })
    end,
  }
}
