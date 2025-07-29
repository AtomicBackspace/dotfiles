return {
  "saghen/blink.cmp",
  event = "InsertEnter",
  dependencies = {
    "rafamadriz/friendly-snippets",
    {
      "saghen/blink.compat",
      version = "2.*",
      lazy = true,
      opts = {
        impersonate_nvim_cmp = true,
        debug = false,
      },
    },
    {
      "xzbdmw/colorful-menu.nvim",
      opts = {
        fallback_highlight = "@comment",
      },
    },
  },
  version = "1.*",

  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
  opts = {
    keymap = { preset = "default", ["<CR>"] = { "accept", "fallback" } },
    cmdline = {
      enabled = true,
      completion = {
        menu = {
          auto_show = false,
        },
      },
    },
    appearance = {
      nerd_font_variant = "mono",
      use_nvim_cmp_as_default = true,
    },
    completion = {
      documentation = {
        auto_show_delay_ms = 500,
        auto_show = true,
        treesitter_highlighting = true,
        window = {
          border = "rounded",
        },
      },
      ghost_text = {
        show_with_selection = true,
        show_with_menu = true,
        show_without_menu = false,
        show_without_selection = false,
        enabled = false,
      },
      list = {
        selection = {
          preselect = true,
          auto_insert = false,
        },
      },
      menu = {
        auto_show = true,
        border = "rounded",
        -- mini icons text
        draw = {
          treesitter = { "lsp" },
          columns = { { "kind_icon" }, { "label", gap = 1 } },
          components = {
            label = {
              text = function(ctx)
                return require("colorful-menu").blink_components_text(ctx)
              end,
              highlight = function(ctx)
                return require("colorful-menu").blink_components_highlight(ctx)
              end,
            },
          },
        },
      },
    },
    signature = { enabled = true, window = { border = "rounded" } },
    sources = {
      default = { "lsp", "path", "snippets", "buffer" },
    },
    fuzzy = { implementation = "prefer_rust_with_warning" },
  },
  opts_extend = { "sources.default" },
  config = function(_, opts)
    require("blink.cmp").setup(opts)

    vim.lsp.config("*", { capabilities = require("blink.cmp").get_lsp_capabilities(nil, true) })
  end,
}
