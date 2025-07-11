local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  { "folke/lazy.nvim" },
  { "nvim-lualine/lualine.nvim" },
  { "nvim-telescope/telescope.nvim", dependencies = { "nvim-lua/plenary.nvim" } },
  { "nvim-tree/nvim-web-devicons" },
  { "neovim/nvim-lspconfig" },
  { "b0o/schemastore.nvim" },
  { "hrsh7th/nvim-cmp" },
  { "hrsh7th/cmp-nvim-lsp" },
  { "hrsh7th/cmp-buffer" },
  { "hrsh7th/cmp-path" },
  { "L3MON4D3/LuaSnip" },
  { "saadparwaiz1/cmp_luasnip" },
  { "nvimtools/none-ls.nvim" },
  { "ray-x/go.nvim", dependencies = { "ray-x/guihua.lua" }, config = true },
  { "iamcco/markdown-preview.nvim", build = "cd app && npm install", ft = {"markdown"} },
  { "eldritch-theme/eldritch.nvim", lazy = false, priority = 1000, opts = {},},
})

vim.cmd('colorscheme eldritch')

require("lualine").setup {
  options = {
    theme = 'eldritch'
  },
}
