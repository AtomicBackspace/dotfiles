vim.api.nvim_create_autocmd({"BufRead", "BufNewFile"}, {
  pattern = "*.md",
  callback = function()
    vim.opt_local.spell = true
    vim.opt.spelllang = "en,sv"
  end
})

vim.api.nvim_create_autocmd("BufEnter", {
  callback = function()
    vim.cmd("syntax sync maxlines=200")
  end
})

-- Prettier
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = {"*.js", "*.ts", "*.json", "*.css"},
  command = "silent! %!prettier --stdin-filepath %"
})
