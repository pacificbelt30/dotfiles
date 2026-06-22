-- toggleterm.nvim (旧 plugins/toggleterm.rc.vim)
require('toggleterm').setup({})

-- ターミナル内では count 付きで特定のターミナルを開ける
vim.api.nvim_create_autocmd('TermEnter', {
  pattern = 'term://*toggleterm#*',
  callback = function(ev)
    vim.keymap.set('t', '<C-t>', [[<Cmd>exe v:count1 . "ToggleTerm"<CR>]], { silent = true, buffer = ev.buf })
  end,
})

-- By applying the mappings this way you can pass a count to your
-- mapping to open a specific window.
-- For example: 2<C-t> will open terminal 2
vim.keymap.set('n', '<C-t>', [[<Cmd>exe v:count1 . "ToggleTerm"<CR>]], { silent = true })
vim.keymap.set('i', '<C-t>', [[<Esc><Cmd>exe v:count1 . "ToggleTerm"<CR>]], { silent = true })
