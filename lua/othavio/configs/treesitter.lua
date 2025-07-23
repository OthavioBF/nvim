require("nvim-treesitter.configs").setup({
  ensure_installed = {
    "vimdoc",
    "javascript",
    "typescript",
    "go",
    "tsx",
    "html",
    "css",
    "prisma",
    "json",
    "lua",
    "css"
  },
  auto_install = true,
  indent = {
    enable = true,
  },

  highlight = {
    enable = true,
    use_languagetree = true,
  },
})
