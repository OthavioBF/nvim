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
vim.keymap.set("n", "<leader><C-h>", function() harpoon:list():replace_at(1) end)
vim.keymap.set("n", "<leader><C-j>", function() harpoon:list():replace_at(2) end)
vim.keymap.set("n", "<leader><C-k>", function() harpoon:list():replace_at(3) end)
vim.keymap.set("n", "<leader><C-l>", function() harpoon:list():replace_at(4) end)
vim.keymap.set("n", "<leader>hc", function() harpoon:list():clear() end)

-- Comment
vim.keymap.set("n", "<leader>/", "gcc", { desc = "toggle comment", remap = true })
vim.keymap.set("v", "<leader>/", "gc", { desc = "toggle comment", remap = true })

-- Nvimtree

vim.keymap.set("n", "<C-n>", "<cmd>NvimTreeToggle<CR>", { desc = "nvimtree toggle window" })
vim.keymap.set("n", "<leader>e", "<cmd>NvimTreeFocus<CR>", { desc = "nvimtree focus window" })

-- Telescope

local builtin = require("telescope.builtin")

vim.keymap.set("n", "<leader>pf", builtin.find_files, {})
vim.keymap.set("n", "<leader>fz", builtin.lsp_document_symbols, {})
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
  end,
})

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

-- vim.keymap.set("n", "<leader>n", function()
--   local env_file = vim.fs.find(".env", { upward = true, type = "file" })[1]
--
--   if not env_file then
--     print("'.env' file not found! Cannot determine project root.")
--     return
--   end
--
--   local project_root = vim.fs.dirname(env_file)
--
--   local file = vim.fn.expand("%:p")
--
--   if not file:find(project_root, 1, true) then
--     print("File is outside the project directory!")
--     return
--   end
--
--   local path = file:sub(#project_root + 1)
--   if not path then
--     print("Error extracting relative path!")
--     return
--   end
--
--   local ftp_host = vim.env.FTP_HOST
--   local ftp_port = vim.env.FTP_PORT
--   local ftp_user = vim.env.FTP_USER
--   local ftp_pass = vim.env.FTP_PASS
--   local ftp_remote_path = vim.env.FTP_REMOTE_PATH
--
--   if not (ftp_host and ftp_port and ftp_user and ftp_pass and ftp_remote_path) then
--     print("FTP credentials not set! Check your .env file.")
--     return
--   end
--
--   local cmd = string.format(
--     "lftp -u '%s','%s' -p %s %s -e 'put %s -o %s; bye'",
--     ftp_user, ftp_pass, ftp_port, ftp_host, file, ftp_remote_path .. path
--   )
--
--   local handle = io.popen(cmd)
--   if not handle then
--     vim.notify("Failed to start FTP upload command.", vim.log.levels.ERROR)
--     return
--   end
--
--   local result = handle:read("*a")
--   local ok, _, code = handle:close()
--
--   if ok then
--     vim.notify("Upload successful: " .. ftp_remote_path .. path, vim.log.levels.INFO)
--   else
--     vim.notify("Upload failed with code " .. tostring(code) .. ":\n" .. result, vim.log.levels.ERROR)
--   end
-- end)
