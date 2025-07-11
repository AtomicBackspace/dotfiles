return {
  { "b0o/schemastore.nvim" },
  {
    "williamboman/mason.nvim",
    build  = ":MasonUpdate",
    config = true,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = {
      "neovim/nvim-lspconfig",
      "hrsh7th/nvim-cmp",
      "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
      require("mason").setup()
      require("mason-lspconfig").setup({
        ensure_installed      = { "gopls", "pyright", "yamlls" },
        automatic_installation = true,
      })

      local lspconfig   = require("lspconfig")
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      lspconfig.gopls.setup({
        capabilities = capabilities,
        settings = {
          gopls = {
            gofumpt            = true,
            staticcheck        = true,
            usePlaceholders    = true,
            completeUnimported = true,
            analyses = {
              unusedparams = true,
              nilness      = true,
              unusedwrite  = true,
            },
          },
        },
      })

      lspconfig.pyright.setup({
        capabilities = capabilities,
      })

      lspconfig.terraformls.setup({
        cmd = { "/usr/bin/tofu" },
      })

      lspconfig.bashls.setup({})

      lspconfig.yamlls.setup({
        capabilities = capabilities,
        settings = {
          yaml = {
            schemaStore = {
              enable = false,
              url = "",
            },
            schemas = require('schemastore').yaml.schemas(),
            validate   = true,
            format     = { enable = true },
            hover      = true,
            completion = true,
          },
        },
      })

      require('lspconfig').lua_ls.setup({
        settings = {
          Lua = {
            runtime = {
              version = 'LuaJIT',
            },
            diagnostics = {
              globals = { 'vim' },
            },
            workspace = {
              library = vim.api.nvim_get_runtime_file("", true),
              checkThirdParty = false,
            },
            format = {
              enable = true,
            },
          },
        },
      })

    end,
  },
}
