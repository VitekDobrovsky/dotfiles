return {
  "kylechui/nvim-surround",
  version = "*", 
  event = "VeryLazy", -- Change this from BufReadPre
  config = function()
    require("nvim-surround").setup({})
  end,
}
