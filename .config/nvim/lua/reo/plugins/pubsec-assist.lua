return {
  {
    "nvim-flutter/pubspec-assist.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "stevearc/dressing.nvim", -- Highly recommended for the search UI
    },
    keys = {
      {
        "<leader>pa",
        function()
          require("pubspec-assist").search_packages(false)
        end,
        desc = "Add Dependency",
      },
      {
        "<leader>pd",
        function()
          require("pubspec-assist").search_packages(true)
        end,
        desc = "Add Dev Dependency",
      },
    },
    config = function()
      require("pubspec-assist").setup()
    end,
  },
}
