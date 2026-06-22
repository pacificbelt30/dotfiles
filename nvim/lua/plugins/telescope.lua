-- telescope.nvim (旧 plugins/lua/telescoperc.lua)
-- vim.keymap.set('n', '<leader>n', '<cmd>Telescope find_files<cr>', { noremap = true })

require('telescope').setup({
  pickers = {
    buffers = {
      sort_lastused = true,
    },
  },
})
