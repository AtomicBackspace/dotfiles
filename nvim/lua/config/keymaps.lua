-- Tab navigate between buffers:
vim.keymap.set("n", "<Tab>", ":bn<CR>")
vim.keymap.set("n", "<S-Tab>", ":bp<CR>")

-- Simplify pane movement
vim.keymap.set("n", "<C-j>", ":wincmd j<CR>")
vim.keymap.set("n", "<C-k>", ":wincmd k<CR>")
vim.keymap.set("n", "<C-l>", ":wincmd l<CR>")
vim.keymap.set("n", "<C-h>", ":wincmd h<CR>")

--- Clipboard settings
vim.api.nvim_set_keymap('v', '<Leader>c', '"+y', { noremap = true, silent = true }) -- Backslash+C

--- Disable command history
vim.api.nvim_set_keymap("n", "q:", "<nop>", { silent = true })
