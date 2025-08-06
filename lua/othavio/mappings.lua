vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

vim.keymap.set("n", "<leader>rn", function()
  return ":IncRename " .. vim.fn.expand("<cword>")
end, { expr = true })

vim.keymap.set('n', '<leader>sw', '<cmd>lua require("spectre").open_visual({select_word=true})<CR>', {
  desc = "Search current word"
})

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { silent = true })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { silent = true })

vim.keymap.set('n', '<C-a>', 'ggVG')

vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

vim.keymap.set("x", "<leader>p", [["_dP]])
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])
vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]])
vim.keymap.set("x", "x", "_x")

vim.keymap.set("v", "'", [[<Esc>`<i"<Esc>`>a"<Esc>]], { noremap = true, silent = true })
vim.keymap.set("v", '"', '"<CR>"')

vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

vim.keymap.set('n', 'zf', 'v$%zf')

vim.keymap.set({ 'n', 'i', 'v' }, '<C-s>', vim.cmd.w)

vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)

vim.keymap.set("v", "<Tab>", ">gv", { noremap = true, silent = true })
vim.keymap.set("v", "<S-Tab>", "<gv", { noremap = true, silent = true })

-- Harpoon

local harpoon = require("harpoon")

harpoon:setup()

vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end)
vim.keymap.set("n", "<C-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

vim.keymap.set("n", "<C-h>", function() harpoon:list():select(1) end)
vim.keymap.set("n", "<C-j>", function() harpoon:list():select(2) end)
vim.keymap.set("n", "<C-k>", function() harpoon:list():select(3) end)
vim.keymap.set("n", "<C-l>", function() harpoon:list():select(4) end)
vim.keymap.set("n", "<leader>hc", function() harpoon:list():clear() end)

-- Comment
vim.keymap.set("n", "<leader>/", "gcc", { desc = "toggle comment", remap = true })
vim.keymap.set("v", "<leader>/", "gc", { desc = "toggle comment", remap = true })

-- Nvimtree

vim.keymap.set("n", "<C-n>", "<cmd>NvimTreeToggle<CR>", { desc = "nvimtree toggle window" })
vim.keymap.set("n", "<leader>e", "<cmd>NvimTreeFocus<CR>", { desc = "nvimtree focus window" })

-- Fugitive

vim.keymap.set("n", "<leader>gs", vim.cmd.Git)

vim.api.nvim_create_autocmd("BufWinEnter", {
  group = vim.api.nvim_create_augroup("ThePrimeagen_Fugitive", {}),
  pattern = "*",
  callback = function()
    if vim.bo.ft ~= "fugitive" then
      return
    end

    local bufnr = vim.api.nvim_get_current_buf()
    local opts = { buffer = bufnr, remap = false, silent = true }

    vim.keymap.set("n", "<leader>gp", function()
      vim.cmd.Git('push')
    end, opts)

    vim.keymap.set("n", "<leader>gf", function()
      vim.cmd.Git('fetch')
    end, opts)

    vim.keymap.set("n", "<leader>gP", function()
      vim.cmd.Git('pull')
    end, opts)

    -- Branch operations
    vim.keymap.set("n", "<leader>gb", function()
      local branch = vim.fn.input("New branch name > ")
      if branch ~= "" then
        vim.cmd.Git('checkout -b ' .. branch)
      end
    end, opts)

    vim.keymap.set("n", "<leader>gB", function()
      local branch = vim.fn.input("Switch to branch > ")
      if branch ~= "" then
        vim.cmd.Git('checkout ' .. branch)
      end
    end, opts)

    vim.keymap.set("n", "<leader>gpu", function()
      -- Get current branch name
      local branch = vim.fn.system("git branch --show-current"):gsub("\n", "")
      if branch ~= "" then
        vim.cmd.Git('push -u origin ' .. branch)
      else
        print("Could not determine current branch")
      end
    end, opts)
  end,
})

-- Telescope

local builtin = require("telescope.builtin")

vim.keymap.set("n", "<C-p>", builtin.git_files)

vim.keymap.set("n", "<leader>gl", function()
  local file = vim.fn.expand("%")
  vim.cmd("Git log -- " .. file)
end)

vim.keymap.set("n", "<leader>gd", ':Gvdiffsplit HEAD<CR>', { silent = true })
vim.keymap.set("n", "<leader>gBd", function()
  local branch = vim.fn.input("Branch > ")
  return ':Gvdiffsplit origin' .. branch
end)
vim.keymap.set("n", "gu", "<cmd>diffget //2<CR>")
vim.keymap.set("n", "gh", "<cmd>diffget //3<CR>")

-- NvChad Theme Picker

vim.keymap.set('n', '<leader>th', function()
  require('nvchad.themes').open()
end)

-- Php utils

vim.keymap.set("n", "<leader>ru", "<cmd>%s/utf8_encode(\\([^)]*\\))/\\1/g<CR>", { silent = true })
