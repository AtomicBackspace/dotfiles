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
      vim.cmd.colorscheme("eldritch")

      local normal_hl = vim.api.nvim_get_hl(0, { name = "EndOfBuffer", link = false })
      local bg_color = normal_hl.fg and string.format("#%06x", normal_hl.fg) or nil

      if bg_color then
        vim.api.nvim_set_hl(0, "NormalNC", { bg = bg_color })
      end
    end,
  },
}
