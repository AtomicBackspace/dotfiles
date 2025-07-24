return {
  "iamcco/markdown-preview.nvim",
  cmd    = { "MarkdownPreview", "MarkdownPreviewToggle", "MarkdownPreviewStop" },
  ft     = { "markdown" },
  build  = function()
    vim.fn["mkdp#util#install"]()
  end,
  config = function()
    vim.g.mkdp_preview_options = {
      markdown_it_plugins = {
        "markdown-it-plantuml"
      },
      uml = {
        server = "http://127.0.0.1:8889"
      }
    }
    vim.g.mkdp_auto_start = 0
    vim.g.mkdp_auto_close = 1
  end,
}
