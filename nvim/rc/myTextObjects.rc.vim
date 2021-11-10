" vim-textobj-userを用いた自分用テキストオブジェクト定義
call textobj#user#plugin('tex', {
\   'environment': {
\     'pattern': ['\\begin{.*}.*\n', '\\end{.*}'],
\     'select-a': 'ae',
\     'select-i': 'ie',
\   },
\ })

