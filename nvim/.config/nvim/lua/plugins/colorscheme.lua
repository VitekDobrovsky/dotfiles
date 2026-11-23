-- return {
--   {
--     "rebelot/kanagawa.nvim",
--     lazy = false,
--     priority = 1000,
--     config = function()
--       vim.cmd("colorscheme kanagawa")
--     end,
--   },
-- }

return {
  {
    "EdenEast/nightfox.nvim",
    lazy = false,
    priority = 1000, 
    config = function()
      require("nightfox").setup({
        options = {
          transparent = true, 
        }
      })
      vim.cmd("colorscheme carbonfox")
    end,
  },

  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "carbonfox",
    },
  },
}
