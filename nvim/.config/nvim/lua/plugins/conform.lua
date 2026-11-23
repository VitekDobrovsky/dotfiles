return {
  {
    "stevearc/conform.nvim",
    opts = {
      formatters = {
        prettier_custom = {
          command = "prettier",
          args = { "--stdin-filepath", "$FILENAME", "--print-width", "200" },
        },
        ["clang-format"] = {
          prepend_args = { "-style=file" },
        },
      },
      formatters_by_ft = {
        javascript = { "prettier_custom" },
        typescript = { "prettier_custom" },
        javascriptreact = { "prettier_custom" },
        typescriptreact = { "prettier_custom" },
        json = { "prettier_custom" },
        css = { "prettier_custom" },
        html = { "prettier_custom" },
        markdown = { "prettier_custom" },
        yaml = { "prettier_custom" },
        cpp = { "clang-format" },
        c = { "clang-format" },
      },
    },
  },
}
