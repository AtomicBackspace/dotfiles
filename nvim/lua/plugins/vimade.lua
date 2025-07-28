return {
  {
    "TaDaa/vimade",
    opts = {
      ncmode = "windows",
      fadelevel = 0.65,
    },
    config = function(_, opts)
      require("vimade").setup(opts)
    end,
  },
}
