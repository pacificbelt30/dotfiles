" This file contains the configuration for the rainbow_parentheses plugin

let g:rainbow#max_level = 16
let g:rainbow#pairs = [['(', ')'], ['[', ']'], ['{','}']]
augroup rainbowparentheses
  autocmd!
  autocmd VimEnter * RainbowParentheses
augroup END
