return {
  {
    "TaDaa/vimade",
    opts = {
      ncmode = "windows",
      fadelevel = 0.7,
      tint = {
        fg = { rgb = { 33, 35, 55 }, intensity = 0.6 },
      },
    },
    config = function(_, opts)
      require("vimade").setup(opts)
    end,
  },
}
