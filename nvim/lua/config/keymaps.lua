-- Tab navigate between buffers
vim.keymap.set("n", "<Tab>", ":bn<CR>")
vim.keymap.set("n", "<S-Tab>", ":bp<CR>")

-- Simplify pane movement
vim.keymap.set("n", "<C-j>", ":wincmd j<CR>")
vim.keymap.set("n", "<C-k>", ":wincmd k<CR>")
vim.keymap.set("n", "<C-l>", ":wincmd l<CR>")
vim.keymap.set("n", "<C-h>", ":wincmd h<CR>")

-- Make saving and quitting commands ignore case
vim.cmd [[
  cnoreabbrev W! w!
  cnoreabbrev Q q
  cnoreabbrev Q! qa!
  cnoreabbrev q! qa!
  cnoreabbrev Qall! qall!
  cnoreabbrev Wq wq
  cnoreabbrev Wa wa
  cnoreabbrev wQ wq
  cnoreabbrev WQ wq
  cnoreabbrev W w
  cnoreabbrev Qall qall
]]

--- Setup Netrw behavior as vim (:E open the directory the current file is located in)
vim.api.nvim_create_user_command('E', function()
  vim.cmd('e ' .. vim.fn.expand('%:p:h'))
end, {})

--- Clipboard settings
vim.api.nvim_set_keymap('n', '<C-c>', '"*y', { noremap = true, silent = true }) -- CTRL+C
vim.api.nvim_set_keymap('v', '<C-c>', '"*y', { noremap = true, silent = true }) -- CTRL+C

--- Disable command history
vim.api.nvim_set_keymap("n", "q:", "<nop>", { silent = true })
