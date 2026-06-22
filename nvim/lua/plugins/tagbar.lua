-- vista.vim (旧 plugins/tagbar.rc.vim)
local g = vim.g

g.vista_icon_indent = { '╰─▸ ', '├─▸ ' }
g.vista_default_executive = 'ctags'
g.vista_fzf_preview = { 'right:50%' }
g.vista_executive_for = {
  tex = 'coc',
  python = 'coc',
}
g['vista#renderer#enable_icon'] = 1
g['vista#renderer#icons'] = {
  ['function'] = vim.fn.nr2char(0xf794),
  variable = vim.fn.nr2char(0xf71b),
}
vim.keymap.set('n', '<F12>', ':Vista!!<CR>')

vim.api.nvim_create_augroup('vista', { clear = true })
-- autocmd VimEnter * Vista
