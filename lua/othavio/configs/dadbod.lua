-- Dadbod configuration

-- Ensure database executables are in PATH
vim.env.PATH = vim.env.PATH .. ":/opt/homebrew/bin:/usr/local/bin:/opt/homebrew/opt/postgresql@17/bin"

-- Use nerd fonts for icons
vim.g.db_ui_use_nerd_fonts = 1

-- Show help text in the drawer
vim.g.db_ui_show_help = 1

-- Auto execute table helpers
vim.g.db_ui_auto_execute_table_helpers = 1

-- Use default connection if available
vim.g.db_ui_use_nvim_notify = 1

-- Save location for queries
vim.g.db_ui_save_location = vim.fn.stdpath("data") .. "/db_ui"

-- Force winwidth
vim.g.db_ui_winwidth = 30

-- Enable completion
vim.g.db_completion_enabled = 1

-- Execute query on save (ENABLE THIS)
vim.g.db_ui_execute_on_save = 1

-- Show query result in split
vim.g.db_ui_show_database_icon = 1

-- Configure DBUI panel position on the left
vim.g.db_ui_win_position = 'left'

-- Default table helpers
vim.g.db_ui_table_helpers = {
  mysql = {
    Count = "select count(1) from {optional_schema}{table}",
    Explain = "EXPLAIN {last_query}"
  },
  postgresql = {
    Count = "select count(1) from {optional_schema}{table}",
    Explain = "EXPLAIN ANALYZE {last_query}"
  },
  sqlite = {
    Count = "select count(1) from {table}",
    Explain = "EXPLAIN QUERY PLAN {last_query}"
  }
}

-- Hide schemas by default
vim.g.db_ui_hide_schemas = { 'information_schema', 'mysql', 'sys', 'performance_schema' }

vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    if vim.g.db_ui_last_query_info then
      vim.g.db_ui_last_query_info = nil
    end
  end,
})

-- Setup dadbod completion autocmds
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "sql", "mysql", "plsql" },
  callback = function()
    vim.api.nvim_buf_set_option(0, 'omnifunc', 'vim_dadbod_completion#omni')

    local cmp = require('cmp')
    cmp.setup.buffer({
      sources = cmp.config.sources({
        { name = 'vim-dadbod-completion' },
      }, {
        { name = 'buffer' },
      })
    })
  end,
})

-- Setup specific autocmds for DBUI query buffers
vim.api.nvim_create_autocmd("FileType", {
  pattern = "dbui",
  callback = function()
    vim.opt_local.number = true
    vim.opt_local.relativenumber = true
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "dbout",
  callback = function()
    -- Make result buffers more readable
    vim.opt_local.wrap = false
    vim.opt_local.number = false
    vim.opt_local.relativenumber = false
    vim.opt_local.signcolumn = "no"

    -- Set result buffer to 60% height
    vim.defer_fn(function()
      local win = vim.api.nvim_get_current_win()
      local total_height = vim.o.lines
      local desired_height = math.floor(total_height * 0.6)
      vim.api.nvim_win_set_height(win, desired_height)
    end, 100)
  end,
})

-- Custom function to execute selected SQL
local function execute_selected_sql()
  -- Get visual selection
  local start_pos = vim.fn.getpos("'<")
  local end_pos = vim.fn.getpos("'>")
  local lines = vim.fn.getline(start_pos[2], end_pos[2])

  if #lines == 0 then
    vim.notify("No selection found", vim.log.levels.WARN)
    return
  end

  -- Handle partial line selection
  if #lines == 1 then
    lines[1] = string.sub(lines[1], start_pos[3], end_pos[3])
  else
    lines[1] = string.sub(lines[1], start_pos[3])
    lines[#lines] = string.sub(lines[#lines], 1, end_pos[3])
  end

  local query = table.concat(lines, "\n")

  -- Execute the selected query
  vim.cmd("DB " .. query)
end

-- Make the function globally available
_G.execute_selected_sql = execute_selected_sql
