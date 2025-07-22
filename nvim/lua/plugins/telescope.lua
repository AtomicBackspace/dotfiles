return {
  {
    "nvim-telescope/telescope-ui-select.nvim",
  },
  {
    'nvim-telescope/telescope-fzf-native.nvim',
    build = 'make',
  },
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.5",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope-file-browser.nvim",
    },
    config = function()
      require("telescope").setup({
        extensions = {
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

      local builtin = require("telescope.builtin")
      vim.keymap.set("n", "<C-p>", builtin.find_files, {})
      vim.keymap.set("n", "<space><space>", builtin.live_grep, {})
      vim.keymap.set("n", "<leader>e", function()
        builtin.find_files({
          vim.fn.expand("%:p:h")
        })
      end, {})
      vim.keymap.set("n", "<leader>fg", builtin.oldfiles, {})
      vim.keymap.set("n", "<leader>d", builtin.lsp_definitions, {})

      -- Replace netrw properly
      vim.api.nvim_create_user_command("E", function()
        builtin.find_files({
          vim.fn.expand("%:p:h")
        })
      end, {})

      require("telescope").load_extension("ui-select")
      require("telescope").load_extension("file_browser")
    end,
  },
}
