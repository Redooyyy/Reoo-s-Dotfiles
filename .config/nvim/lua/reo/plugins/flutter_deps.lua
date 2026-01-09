return {
  "Redooyyy/flutter-deps.nvim",
  dependencies = {
    "nvim-telescope/telescope.nvim",
    "nvim-lua/plenary.nvim",
  },
  config = function()
    require("flutter_deps").setup()

    vim.keymap.set("n", "<leader>pd", function()
      require("flutter_deps").add_dependency()
    end, { desc = "Add pub.dev dependency" })
  end,
}
