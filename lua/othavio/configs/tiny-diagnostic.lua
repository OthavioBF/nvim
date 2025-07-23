require('tiny-inline-diagnostic').setup({
  preset = 'classic',
  transparent_bg = true,
  transparent_cursorline = true,
  hi = {
    mixing_color = 'None'
  },
  options = {
    multilines = {
      enabled = true
    }
  }
})
vim.diagnostic.config({ virtual_text = false })
