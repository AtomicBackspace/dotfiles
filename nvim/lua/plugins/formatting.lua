return {
  "stevearc/conform.nvim",
  event = { "BufWritePre" },
  cmd = { "ConformInfo" },
  keys = {
    {
      "<leader>f",
      function()
        require("conform").format({ lsp_fallback = true, async = true, timeout_ms = 500 })
      end,
      desc = "Format document",
    },
  },
  opts = {
    log_level = vim.log.levels.DEBUG,
    formatters_by_ft = {
      lua = { "stylua" },
      go = { "gofumpt" },
      javascript = { "prettierd" },
      typescript = { "prettierd" },
      css = { "prettierd" },
      html = { "prettierd", "prettier", stop_after_first = true },
      gohtml = { "prettierd", "prettier", stop_after_first = true },
      json = { "prettierd" },
      markdown = { "prettierd" },
      md = { "prettierd" },
      ["_"] = { "trim_whitespace", "trim_newlines" },
    },
    default_format_opts = {
      lsp_format = "fallback",
    },
    format_after_save = function()
      if not vim.g.autoformat then
        return nil
      end

      return {
        async = true,
        lsp_format = "fallback",
        timeout_ms = 500,
      }
    end,
  },
  init = function()
    vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
    vim.g.autoformat = true
  end,
  config = function(_, opts)
    require("conform").setup(opts)
  end,
}
