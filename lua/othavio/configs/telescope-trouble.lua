-- Telescope-Trouble Integration Configuration
local M = {}

function M.setup()
  local telescope = require("telescope")
  local builtin = require('telescope.builtin')
  local trouble = require('trouble')

  -- Enhanced telescope configuration with trouble integration
  telescope.setup({
    defaults = {
      prompt_prefix = "   ",
      selection_caret = " ",
      entry_prefix = " ",
      sorting_strategy = "ascending",
      layout_config = {
        horizontal = {
          prompt_position = "top",
          preview_width = 0.55,
        },
        width = 0.87,
        height = 0.80,
      },
      mappings = {
        i = {
          -- Send telescope results to trouble with Ctrl+t
          ["<c-t>"] = function(...)
            return require("trouble.providers.telescope").open_with_trouble(...)
          end,
          ["<C-h>"] = "which_key",
        },
        n = {
          -- Send telescope results to trouble with Ctrl+t in normal mode
          ["<c-t>"] = function(...)
            return require("trouble.providers.telescope").open_with_trouble(...)
          end,
        },
      },
    },
    extensions_list = { "themes", "terms" },
    extensions = {},
  })

  -- Enhanced keymaps for telescope with trouble integration
  vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Find files' })
  vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Live grep' })
  vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Find buffers' })
  vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Help tags' })
  vim.keymap.set('n', '<leader>fr', builtin.oldfiles, { desc = 'Recent files' })
  vim.keymap.set('n', '<leader>fc', builtin.commands, { desc = 'Commands' })
  vim.keymap.set('n', '<leader>fk', builtin.keymaps, { desc = 'Keymaps' })

  -- LSP and diagnostics with telescope (can be sent to trouble with <C-t>)
  vim.keymap.set('n', '<leader>fd', function()
    builtin.diagnostics({ bufnr = 0 })
  end, { desc = 'Diagnostics for current buffer (use <C-t> to send to Trouble)' })
  vim.keymap.set('n', '<leader>fs', builtin.lsp_document_symbols, { desc = 'Document symbols' })
  vim.keymap.set('n', '<leader>fw', builtin.lsp_workspace_symbols, { desc = 'Workspace symbols' })
  vim.keymap.set('n', '<leader>fi', builtin.lsp_implementations, { desc = 'Implementations' })
  vim.keymap.set('n', '<leader>ft', builtin.lsp_type_definitions, { desc = 'Type definitions' })
  vim.keymap.set('n', '<leader>fR', builtin.lsp_references, { desc = 'References (use <C-t> to send to Trouble)' })

  -- Git integration
  vim.keymap.set("n", "<C-p>", builtin.git_files)
  vim.keymap.set('n', '<leader>gc', builtin.git_commits, { desc = 'Git commits' })
  vim.keymap.set('n', '<leader>gb', builtin.git_branches, { desc = 'Git branches' })

  -- Custom functions for better telescope-trouble workflow
  vim.keymap.set('n', '<leader>fD', function()
    -- Open diagnostics in telescope, ready to send to trouble
    builtin.diagnostics({
      severity_limit = vim.diagnostic.severity.WARN, -- Only show warnings and errors
    })
  end, { desc = 'Diagnostics (filtered, use <C-t> for Trouble)' })

  vim.keymap.set('n', '<leader>fE', function()
    -- Open only errors in telescope
    builtin.diagnostics({
      severity_limit = vim.diagnostic.severity.ERROR,
    })
  end, { desc = 'Errors only (use <C-t> for Trouble)' })

  -- Quick workflow: Open diagnostics directly in trouble
  vim.keymap.set('n', '<leader>td', function()
    trouble.toggle("workspace_diagnostics")
  end, { desc = 'Toggle Trouble diagnostics' })

  vim.keymap.set("n", "<leader>pws", function()
    local word = vim.fn.expand("<cword>")
    builtin.grep_string({ search = word })
  end)

  vim.keymap.set('n', '<leader>tr', function()
    trouble.toggle("lsp_references")
  end, { desc = 'Toggle Trouble references' })

  -- Workflow keymaps for seamless navigation
  vim.keymap.set('n', '<leader>tn', function()
    trouble.next({ skip_groups = true, jump = true })
  end, { desc = 'Next trouble item' })

  vim.keymap.set('n', '<leader>tp', function()
    trouble.previous({ skip_groups = true, jump = true })
  end, { desc = 'Previous trouble item' })
end

return M
