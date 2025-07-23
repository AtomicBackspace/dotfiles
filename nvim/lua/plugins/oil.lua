return {
  {
    "stevearc/oil.nvim",
    opts = {},
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    lazy = false,
    config = function()
      require("oil").setup({
        default_file_explorer = true,
        columns = { "icon" },
        view_options = {
          show_hidden = true,
        },
        keymaps = {
          ["q"] = { "actions.close", mode = "n" },
        },
      })

      vim.keymap.set("n", "<leader>e", ":Oil<CR>", {})
      vim.api.nvim_create_user_command("E", function()
        require("oil").open()
      end, {})
    end,
  }
}
