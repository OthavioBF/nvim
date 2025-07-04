local M = {}

local zen_active = false
local original_settings = {}

function M.toggle()
  local win = vim.api.nvim_get_current_win()
  local buf = vim.api.nvim_get_current_buf()

  if not zen_active then
    -- Save original settings
    original_settings = {
      number = vim.wo[win].number,
      relativenumber = vim.wo[win].relativenumber,
      signcolumn = vim.wo[win].signcolumn,
      list = vim.wo[win].list,
      showtabline = vim.o.showtabline,
      laststatus = vim.o.laststatus,
      wrap = vim.wo[win].wrap,
      colorcolumn = vim.wo[win].colorcolumn,
    }

    -- Set "Zen" view
    vim.wo[win].number = false
    vim.wo[win].relativenumber = false
    vim.wo[win].signcolumn = "no"
    vim.wo[win].list = false
    vim.wo[win].wrap = true
    vim.wo[win].colorcolumn = ""
    vim.o.showtabline = 0
    vim.o.laststatus = 0

    -- Add some padding using `textwidth` and `colorcolumn`
    vim.bo[buf].textwidth = 80
    vim.wo[win].colorcolumn = "+1"

    zen_active = true
  else
    -- Restore settings
    vim.wo[win].number = original_settings.number
    vim.wo[win].relativenumber = original_settings.relativenumber
    vim.wo[win].signcolumn = original_settings.signcolumn
    vim.wo[win].list = original_settings.list
    vim.wo[win].wrap = original_settings.wrap
    vim.o.showtabline = original_settings.showtabline
    vim.o.laststatus = original_settings.laststatus
    vim.wo[win].colorcolumn = original_settings.colorcolumn

    zen_active = false
  end
end

return M

