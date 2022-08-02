
local api = vim.api
--api.nvim_set_keymap('n', ' n', '<cmd>Telescope find_files<cr>', { noremap = true })

local actions = require('telescope.actions')require('telescope').setup{
  pickers = {
    buffers = {
      sort_lastused = true
    }
  }
}
