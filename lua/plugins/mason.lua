return {
  {
    "mason-org/mason.nvim",
    opts = function(_, opts)
      -- Add any tools (formatters, linters, DAPs) you want Mason to manage
      vim.list_extend(opts.ensure_installed, {
        "ast-grep",
        "bash-language-server",
        "clang-format",
        "clangd",
        "codelldb",
        "cpplint",
        "css-lsp",
        "delve",
        "gofumpt",
        "goimports",
        "golangci-lint",
        "gopls",
        "html-lsp",
        "json-lsp",
        "lua-language-server",
        "markdown-toc",
        "markdownlint-cli2",
        "marksman",
        "prettier",
        "shellcheck",
        "shfmt",
        "stylelint",
        "stylua",
        "tree-sitter-cli",
        "wc-language-server",
      })
    end,
  },
}
