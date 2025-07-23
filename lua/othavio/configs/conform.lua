return {
  formatters_by_ft = {
    lua = { "stylua" },

    go = { "gofumpt", "goimports-reviser", "golines" },

    kotlin = { "ktlint" },

    javascript = { "biome-check" },
    javascriptreact = { "biome-check" },
    typescript = { "biome-check" },
    typescriptreact = { "biome-check" },
  },
  format_after_save = {
    async = true,
    lsp_fallback = true,
  },
}
