return {
  "folke/snacks.nvim",
  opts = {
    picker = {
      sources = {
        explorer = {
          hidden = false,
          ignored = false,
          layout = {
            layout = {
              position = "right",
            },
          },
        },
        files = {
          hidden = false,
          ignored = false,
        },
      },
    },
  },
  keys = {
    { "<leader>gs", function() Snacks.picker.git_status() end, desc = "Git Status" },
    { "<leader>gS", function() Snacks.picker.git_diff() end, desc = "Git Diff (Hunks)" },
    { "<leader>gf", function() Snacks.picker.git_log_file() end, desc = "Git File History" },
  },
}
