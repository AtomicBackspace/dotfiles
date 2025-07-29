return {
  {
    "neovim/nvim-lspconfig",
    event = "VeryLazy",
    cmd = { "Mason" },
    dependencies = {
      {
        "mason-org/mason.nvim",
        opts = { ui = { border = "rounded" }, build = ":MasonUpdate" },
      },
      "mason-org/mason-lspconfig.nvim",
      "WhoIsSethDaniel/mason-tool-installer.nvim",
      "hrsh7th/nvim-cmp",
      "hrsh7th/cmp-nvim-lsp",
      "b0o/schemastore.nvim",
    },
    opts = {
      lsp_servers = {
        "bashls",
        "cssls",
        "docker_compose_language_service",
        "tailwindcss",
        "tailwindcss-language-server",
        "dockerls",
        "pyright",
        "svelte",
        "terraformls",
        "vimls",
      },
      tools = {
        "prettierd",
        "yamllint",
        "stylua",
      },
    },
    config = function(_, opts)
      -- Get server names from after/lsp
      local servers = {}
      local lsp_servers_path = vim.fn.stdpath("config") .. "/lsp"

      for file in vim.fs.dir(lsp_servers_path) do
        local name = file:match("(.+)%.lua$")
        if name then
          servers[name] = true
        end
      end

      -- Add servers automatically
      local ensure_installed = vim.tbl_keys(servers or {})
      vim.list_extend(ensure_installed, opts.lsp_servers)
      vim.list_extend(ensure_installed, opts.tools)

      require("mason-lspconfig").setup({
        ensure_installed = {},
      })

      require("mason-tool-installer").setup({
        ensure_installed = ensure_installed,
        auto_update = true,
        run_on_start = true,
      })
    end,
  },
}
