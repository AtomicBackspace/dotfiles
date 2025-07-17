return {
  { "b0o/schemastore.nvim" },
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "hrsh7th/nvim-cmp",
      "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
      local lspconfig    = require("lspconfig")
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      lspconfig.gopls.setup({
        capabilities = capabilities,
        settings = {
          gopls = {
            gofumpt            = true,
            staticcheck        = true,
            vulncheck          = "Imports",
            usePlaceholders    = true,
            completeUnimported = true,
            analyses           = {
              unusedparams = true,
              shadow       = true,
              nilness      = true,
              unusedwrite  = true,
              useany       = true,
            },
          },
        },
      })

      lspconfig.pyright.setup({
        capabilities = capabilities,
      })

      lspconfig.terraformls.setup({})

      lspconfig.bashls.setup({})

      lspconfig.yamlls.setup({
        on_attach = function(client)
          client.server_capabilities.documentFormattingProvider = true
        end,
        capabilities = capabilities,
        settings = {
          yaml = {
            schemaStore = {
              enable = false,
              url = "",
            },
            schemas     = require('schemastore').yaml.schemas(),
            validate    = true,
            format      = { enable = true },
            hover       = true,
            completion  = true,
          },
        },
      })

      lspconfig.lua_ls.setup({
        capabilities = capabilities,
        on_attach = function(client, bufnr)
          if client.server_capabilities.documentFormattingProvider then
            vim.api.nvim_create_autocmd("BufWritePre", {
              buffer = bufnr,
              callback = function()
                vim.lsp.buf.format({ async = false })
              end,
            })
          end
        end,
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
