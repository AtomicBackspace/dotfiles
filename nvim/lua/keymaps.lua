vim.keymap.set("n", "<Tab>", ":bn<CR>")
vim.keymap.set("n", "<S-Tab>", ":bp<CR>")
vim.keymap.set("n", "<C-j>", "<C-w>j")
vim.keymap.set("n", "<C-k>", "<C-w>k")
vim.keymap.set("n", "<C-l>", "<C-w>l")
vim.keymap.set("n", "<C-h>", "<C-w>h")

-- Telescope keymaps
vim.keymap.set("n", "<space><space>", ":Telescope find_files<CR>")
vim.keymap.set("n", "<C-p>", ":Telescope live_grep<CR>")
vim.keymap.set("n", "<leader>fh", ":Telescope help_tags<CR>")

vim.cmd [[
  cnoreabbrev W! w!
  cnoreabbrev Q! q!
  cnoreabbrev Qall! qall!
  cnoreabbrev Wq wq
  cnoreabbrev Wa wa
  cnoreabbrev wQ wq
  cnoreabbrev WQ wq
  cnoreabbrev W w
  cnoreabbrev Q q
  cnoreabbrev Qall qall
]]

--- Setup Netrw behavior as vim (:E open the directory the current file is located in)
vim.api.nvim_create_user_command('E', function()
  vim.cmd('e ' .. vim.fn.expand('%:p:h'))
end, {})

--- OS Dependent bindings
local is_mac = vim.fn.has("macunix") == 1

if is_mac then
  -- MacOS keybindings
else
  -- Linux keybindings (using CTRL)
end

--- Clipboard settings
vim.api.nvim_set_keymap('n', '<C-c>', '"*y', { noremap = true, silent = true })  -- CTRL+C
vim.api.nvim_set_keymap('v', '<C-c>', '"*y', { noremap = true, silent = true })  -- CTRL+C
