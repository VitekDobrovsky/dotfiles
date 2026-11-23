-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")
require("toggleterm").setup({
  direction = "float",
  open_mapping = nil,
  start_in_insert = true,
  float_opts = {
    border = "rounded",
  },
  autochdir = true,
})

vim.opt.relativenumber = false
vim.opt.number = true
