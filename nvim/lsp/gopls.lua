--@type vin.lsp.Config
return {
  settings = {
    gopls = {
      gofumpt = true,
      staticcheck = true,
      vulncheck = "Imports",
      usePlaceholders = true,
      completeUnimported = true,
      diagnosticsDelay = "500ms",
      hoverKind = "FullDocumentation",
      semanticTokens = true,
      analyses = {
        unusedparams = true,
        shadow = true,
        nilness = true,
        unusedwrite = true,
        useany = true,
      },
      hints = {
        assignVariableTypes = true,
        compositeLiteralFields = true,
        compositeLiteralTypes = true,
        constantValues = true,
        functionTypeParameters = true,
        parameterNames = true,
        rangeVariableTypes = true,
      },
    },
  },
}
