return {
  {
    "smartpde/telescope-recent-files",
    config = function()
      require("telescope").load_extension("recent_files")
    end
  },
  {
    "nvim-telescope/telescope.nvim",

    tag = "0.1.8",

    dependencies = {
      "nvim-lua/plenary.nvim",
    },

    config = function()
      require("telescope").setup({
        pickers = {
          git_files = {
            previewer = false, -- Disable previewer for git_files
          },
        },
      })

      local builtin = require("telescope.builtin")
      local recent_files = require("telescope").extensions.recent_files
      vim.keymap.set("n", "<leader>pf", builtin.find_files, {})
      vim.keymap.set("n", "<leader>ss", builtin.lsp_document_symbols, {})
      vim.keymap.set("n", "<leader>rf", function()
        recent_files.pick()
      end, {})
      vim.keymap.set("n", "<leader>gc", builtin.git_commits, {})
      vim.keymap.set("n", "<leader>gb", builtin.git_branches, {})
      vim.keymap.set("n", "<C-p>", builtin.git_files)
      vim.keymap.set("n", "<leader>pws", function()
        local word = vim.fn.expand("<cword>")
        builtin.grep_string({ search = word })
      end)
      vim.keymap.set("n", "<leader>pWs", function()
        local word = vim.fn.expand("<cWORD>")
        builtin.grep_string({ search = word })
      end)
      vim.keymap.set("n", "<leader>ps", function()
        builtin.grep_string({ search = vim.fn.input("Grep > ") })
      end)
      vim.keymap.set("n", "<leader>vh", builtin.help_tags, {})
    end,
  }
}
