return {
  {
    "nvim-telescope/telescope-ui-select.nvim",
  },
  {
    'nvim-telescope/telescope-fzf-native.nvim',
    build = 'make',
  },
  {
    "nvim-telescope/telescope-file-browser.nvim",
    dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" }
  },
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.5",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("telescope").setup({
        extensions = {
          ["file_browser"] = {
            hijack_netrw = true,
          },
          ["ui-select"] = {
            require("telescope.themes").get_dropdown({}),
          },
          ["fzf"] = {
            fuzzy = true,
            override_generic_sorter = true,
            override_file_sorter = true,
            case_mode = "smart_case",
          },
        },
      })
      -- require("telescope").load_extension("fzf")

      local builtin = require("telescope.builtin")
      vim.keymap.set("n", "<C-p>", builtin.find_files, {})
      vim.keymap.set("n", "<space><space>", builtin.live_grep, {})
      vim.keymap.set("n", "<space>e", ":Telescope file_browser<CR>")
      vim.keymap.set("n", "<leader>fg", builtin.oldfiles, {})
      vim.keymap.set("n", "<leader>d", builtin.lsp_definitions, {})

      require("telescope").load_extension("ui-select")
    end,
  },
}
