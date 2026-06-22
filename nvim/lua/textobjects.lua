-- vim-textobj-userを用いた自分用テキストオブジェクト定義 (旧 rc/myTextObjects.rc.vim)
vim.fn['textobj#user#plugin']('tex', {
  environment = {
    pattern = { '\\\\begin{.*}.*\\n', '\\\\end{.*}' },
    ['select-a'] = 'ae',
    ['select-i'] = 'ie',
  },
})
