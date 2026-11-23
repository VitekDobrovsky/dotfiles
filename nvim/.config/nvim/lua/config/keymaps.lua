vim.keymap.set("i", "jj", "<Esc>", { noremap = true, silent = true, desc = "Enter normal mode" })


vim.keymap.set("n", "F", "O<Esc>", { silent = true, desc = "Create new line above" })

-- Move line up and down
vim.keymap.set("n", "J", ":m +1<CR>==", { silent = true, desc = "Move line down" })
vim.keymap.set("n", "K", ":m -2<CR>==", { silent = true, desc = "Move line up" })

vim.keymap.set("n", "yd", ":let @+=expand('%:p:h')<CR>", { silent = true, desc = "Yank absolute directory path" })

vim.keymap.set("n", "<leader>cw", function()
  vim.diagnostic.setloclist()
end, { silent = true, desc = "Show diagnostic window" })

vim.keymap.set('n', '<C-o>', 'kJ', { desc = 'Pull current line to end of previous' })

vim.keymap.set("n", "<leader>w", ":wa<CR>", { silent = true, desc = "Save all buffers" })

vim.keymap.set("n", "<leader>gd", function()
  require("gitsigns").diffthis()
end, { desc = "Git diff (current file)" })

-- toggleterm
local trim_spaces = true
vim.keymap.set("v", "<space>s", function()
  require("toggleterm").send_lines_to_terminal("single_line", trim_spaces, { args = vim.v.count })
end)


-- transform string formats - for react dev
vim.keymap.set("n", "<leader>ct", function()
  local line = vim.api.nvim_get_current_line()
  local _, col = unpack(vim.api.nvim_win_get_cursor(0))
  col = col + 1 -- convert to 1-based

  -- Check for template literal {`...`} under cursor
  local search_start = 1
  while true do
    local ts, te, content = line:find("{`(.-)`}", search_start)
    if not ts then break end
    if col >= ts and col <= te then
      local new_line = line:sub(1, ts - 1) .. '"' .. content .. '"' .. line:sub(te + 1)
      vim.api.nvim_set_current_line(new_line)
      return
    end
    search_start = ts + 1
  end

  -- Check for quoted string "..." or '...' under cursor
  search_start = 1
  while true do
    local ts, te, content = line:find('["\']([^"\']*)["\']', search_start)
    if not ts then break end
    if col >= ts and col <= te then
      local new_line = line:sub(1, ts - 1) .. '{`' .. content .. '`}' .. line:sub(te + 1)
      vim.api.nvim_set_current_line(new_line)
      return
    end
    search_start = ts + 1
  end

  vim.notify("No string found under cursor", vim.log.levels.WARN)
end, { silent = true, desc = "Toggle string <-> template literal" })
