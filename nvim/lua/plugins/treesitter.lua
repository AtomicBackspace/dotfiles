return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = "BufReadPost",
    branch = "main",
    lazy = false,
    opts = {
      ensure_installed = {
        "bash",
        "c",
        "css",
        "dockerfile",
        "git_rebase",
        "gitcommit",
        "gitignore",
        "go",
        "gomod",
        "gosum",
        "gpg",
        "hcl",
        "helm",
        "javascript",
        "jinja",
        "jinja_inline",
        "json",
        "lua",
        "make",
        "markdown",
        "markdown_inline",
        "python",
        "query",
        "regex",
        "sql",
        "svelte",
        "tcl",
        "terraform",
        "toml",
        "tsx",
        "typescript",
        "vim",
        "vimdoc",
        "yaml",
      },
    },
    config = function(_, opts)
      require("nvim-treesitter").setup()
      require("nvim-treesitter").install(opts.ensure_installed)

      vim.api.nvim_create_autocmd("FileType", {
        pattern = {
          "javascript",
          "typescript",
          "lua",
          "json",
          "sql",
          "regex",
          "go",
          "gomod",
          "css",
          "sh",
          "markdown",
          "markdown_inline",
          "http",
          "gohtml",
          "vim",
          "vimdoc",
          "gitignore",
          "gitcommit",
          "gitconfig",
          "diff",
          "gitrebase",
          "toml",
          "yaml",
          "python",
        },
        callback = function()
          local ok = pcall(vim.treesitter.start)
          if not ok then
            print("Treesitter not enabling")
            return
          end
        end,
      })
    end,
  },
}
