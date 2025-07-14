return {
  {
    "eldritch-theme/eldritch.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      transparent = true,
    },
    config = function(_, opts)
      require("eldritch").setup(opts)
      vim.cmd.colorscheme("eldritch-dark")
    end,
  },
}
