return {
  on_attach = function(client)
    client.server_capabilities.documentFormattingProvider = true
  end,
  settings = {
    yaml = {
      schemaStore = {
        enable = false,
        url = "",
      },
      schemas     = require('schemastore').yaml.schemas({
        select = {
          ".pre-commit-config.yml",
          ".pre-commit-hooks.yml",
          "GitHub Action",
          "GitHub Workflow",
          "Helm Chart.yaml",
          "cloud-init: cloud-config userdata",
          "docker-compose.yml",
          "gitlab-ci",
          "k9s aliases.yaml",
          "k9s cluster-config.yaml",
          "k9s config.yaml",
          "k9s hotkeys.yaml",
          "k9s plugins.yaml",
          "k9s skin.yaml",
          "k9s views.yaml",
          "kustomization.yaml",
        },
      }),
      validate    = true,
      format      = { enable = true },
      hover       = true,
      completion  = true,
    },
  },
}
