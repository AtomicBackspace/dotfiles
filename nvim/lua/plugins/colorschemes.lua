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
        highlights.BlinkCmpMenu = { fg = colors.dark3 }
        highlights.BlinkCmpDoc = { fg = colors.dark3 }
        highlights.BlinkCmpMenuBorder = { fg = colors.purple }
        highlights.BlinkCmpDocBorder = { fg = colors.bg_visual }
        highlights.BlinkCmpScrollBarThumb = { bg = colors.purple }
        highlights.TelescopeBorder = { fg = colors.purple }
        highlights.TelescopePromptBorder = { fg = colors.bg_highlight }
        highlights.TelescopeResultsTitle = { fg = colors.fg_gutter_light }
        highlights.TelescopeResultsBorder = { fg = colors.bg_highlight }
        highlights.TelescopePreviewTitle = { fg = colors.fg_gutter_light }
        highlights.TelescopePreviewBorder = { fg = colors.bg_highlight }
        highlights.TelescopePromptPrefix = { fg = colors.purple, bg = colors.black }
        highlights.TelescopeNormal = { bg = colors.black }
        highlights.TelescopePromptNormal = { bg = colors.black }
      end,
    },
    config = function(_, opts)
      require("eldritch").setup(opts)
      vim.cmd.colorscheme("eldritch")
    end,
  },
}
