return {
  "nvimtools/none-ls.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  config = function()
    local null_ls = require("null-ls")

    null_ls.setup({
      sources = {
        -- Use Prettier for Markdown, YAML, etc.
        null_ls.builtins.formatting.prettier.with({
          command = "/opt/homebrew/bin/prettier",
          filetypes = { "markdown", "yaml", "json", "html", "css", "javascript", "typescript" },
        }),
      },
      on_attach = function(client, bufnr)
        if client.supports_method("textDocument/formatting") then
          vim.api.nvim_create_autocmd("BufWritePre", {
            group = vim.api.nvim_create_augroup("FormatOnSave", { clear = true }),
            buffer = bufnr,
            callback = function()
              vim.lsp.buf.format({ async = false })
            end,
          })
        end
      end,
      vim.keymap.set("n", "<leader>f", function()
        vim.lsp.buf.format({ async = false })
      end, { desc = "Format current buffer" }),
    })
  end,
}
