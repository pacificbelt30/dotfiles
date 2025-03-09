" This file contains custom text object definitions using vim-textobj-user

" vim-textobj-userを用いた自分用テキストオブジェクト定義
call textobj#user#plugin('tex', {
\   'environment': {
\     'pattern': ['\\begin{.*}.*\n', '\\end{.*}'],
\     'select-a': 'ae',
\     'select-i': 'ie',
\   },
\ })
