return {
  "akinsho/toggleterm.nvim",
  version = "*",
  keys = {
    {
      "<C-.>",
      function()
        vim.cmd("ToggleTerm")
      end,
      mode = { "n", "t" },
      desc = "Toggle Terminal",
    },
  },
  config = function()
    require("toggleterm").setup({
      direction = "float",
      open_mapping = nil,
      start_in_insert = true,
      float_opts = {
        border = "rounded",
      },
    })
  end,
}
