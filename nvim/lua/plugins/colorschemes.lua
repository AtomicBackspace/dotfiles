return {
  {
    "eldritch-theme/eldritch.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      transparent = true,
      styles = {
        keywords = { italic = false },
      },
      on_highlights = function(highlights, colors)
        highlights.MatchParen = { fg = colors.orange, bold = false }
      end,
    },
    config = function(_, opts)
      require("eldritch").setup(opts)
      vim.cmd.colorscheme("eldritch")
    end,
  },
}
