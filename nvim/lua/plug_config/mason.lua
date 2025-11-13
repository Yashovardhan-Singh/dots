return {
    "williamboman/mason.nvim",
    dependencies = { "williamboman/mason-lspconfig.nvim" },
    config = function()
      require("mason").setup()
      require("mason-lspconfig").setup({ ensure_installed = { "clangd" } })

      vim.lsp.config["clangd"] = {
        cmd = { "clangd", "--compile-commands-dir=builddir" },
        filetypes = { "c", "cpp", "objc", "objcpp" },
        root_markers = { "meson.build", ".git", "compile_commands.json", ".clang-format" },
      }
      vim.lsp.enable("clangd")

      vim.keymap.set("n", "<leader>f",
        function() vim.lsp.buf.format({ async = true }) end,
        { desc = "Format with clangd" })
    end,
  }
