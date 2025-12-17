return {
  "hrsh7th/cmp-nvim-lsp",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "neovim/nvim-lspconfig",
    { "antosha417/nvim-lsp-file-operations", config = true },
    { "folke/lazydev.nvim", opts = {} },
  },
  config = function()
    -- import cmp-nvim-lsp plugin
    local cmp_nvim_lsp = require("cmp_nvim_lsp")
    -- used to enable autocompletion (assign to every lsp server config)
    local capabilities = cmp_nvim_lsp.default_capabilities()

    local dartExcludedFolders = {
      --vim.fn.expand("$HOME/AppData/Local/Pub/Cache"),--
      vim.fn.expand("$HOME/.pub-cache"),
      vim.fn.expand("/opt/flutter/bin/cache/dart-sdk/bin/snapshots/analysis_server_aot.dart.snapshot"),
      vim.fn.expand("/usr/bin/flutter"),
    }
    vim.lsp.config("dartls", {
      capabilities = capabilities,
      cmd = {
        "dart",
        "language-server",
        "--protocol=lsp",
        -- "--port=8123",
        -- "--instrumentation-log-file=/Users/robertbrunhage/Desktop/lsp-log.txt",
      },
      filetypes = { "dart" },
      init_options = {
        onlyAnalyzeProjectsWithOpenFiles = false,
        suggestFromUnimportedLibraries = true,
        closingLabels = true,
        outline = false,
        flutterOutline = false,
      },
      settings = {
        dart = {
          analysisExcludedFolders = dartExcludedFolders,
          updateImportsOnRename = true,
          completeFunctionCalls = true,
          showTodos = true,
        },
      },
    })
    vim.lsp.enable("dartls")
    vim.lsp.enable("dcmls")

    --
    -- local lspconfig = require("lspconfig")
    -- lspconfig["dcmls"].setup({
    --   capabilities = capabilities,
    --   default_config = {
    --     cmd = { "dcm", "start-server", "--client=neovim" },
    --     filetypes = { "dart" },
    --   },
    -- })
    -- lspconfig["dartls"].setup({
    --   capabilities = capabilities,
    --   cmd = {
    --     "dart",
    --     "language-server",
    --     "--protocol=lsp",
    --     -- "--port=8123",
    --     -- "--instrumentation-log-file=/Users/robertbrunhage/Desktop/lsp-log.txt",
    --   },
    --   filetypes = { "dart" },
    --   init_options = {
    --     onlyAnalyzeProjectsWithOpenFiles = false,
    --     suggestFromUnimportedLibraries = true,
    --     closingLabels = true,
    --     outline = false,
    --     flutterOutline = false,
    --   },
    --   settings = {
    --     dart = {
    --       analysisExcludedFolders = dartExcludedFolders,
    --       updateImportsOnRename = true,
    --       completeFunctionCalls = true,
    --       showTodos = true,
    --     },
    --   },
    -- })
    vim.lsp.config("*", {
      capabilities = capabilities,
    })
  end,
}
