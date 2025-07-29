return {
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
        severity = {
          ["unused-local"] = "Hint",
          ["redefined-local"] = "Warning",
        },
      },
      completion = {
        callSnippet = "Replace",
        keywordSnippet = "Replace",
        showWord = "Disable",
      },
      workspace = {
        library = vim.api.nvim_get_runtime_file("", true),
        checkThirdParty = false,
        maxPreload = 1000,
        preloadFileSize = 150,
      },
      hint = {
        enable = true,
        setType = true,
        paramType = true,
        await = true,
      },
      semantic = {
        enable = true,
      },
      telemetry = {
        enable = false,
      },
      format = {
        enable = true,
        defaultConfig = {
          indent_style = "space",
          indent_size = "2",
        },
      },
    },
  },
}
