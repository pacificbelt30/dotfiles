"vimのノーマルモードを利用して，vscodeのCtrl+/のようなコメントアウトしたかった
"使い方
"<Space>f ：現在の行をコメントアウト or 現在の行をコメントアウトアウト
"<Space>c ：現在の行をコメントアウト
"n<Space>c：現在の行からn行分をコメントアウト
"<Space>C ：現在の行のコメントアウトを解除
"n<Space>C：現在の行からn行分のコメントアウトを解除
"GetComMozi関数とGetRegComMozi関数とGetComMoziNE関数に拡張子と対応するコメントアウト文字を設定することでコメントアウトキーバインドを利用できる
"GetRegComMozi関数に設定する文字は正規表現により入力する
"GetComMoziNE関数に設定する文字はGetComMozi関数のエスケープ文字を抜いたやつを入力する
"コメントアウト関数
function! Com(...)
  let filenum = line("$") - line(".")
  let num = 0
  let currentLine = line(".")
  if a:0 >0
    let num = a:1-1
    let filenum -= (a:1-1)
  endif
  let ex = expand("%:e")
  if filenum <= 0
    let num = line("$") - line(".")
  endif
  "exec ":UnCommentOut " . l:num . "<CR>"
  let ex = GetComMozi()
  let exr = GetRegComMozi()
  if l:ex == ""
    return 0
  endif
  let jf = a:firstline - a:lastline
"  exec ":" . l:currentLine . ",+" . l:num . "s/^\\zs".l:exr."\\ze.*$/".l:ex
  exec ":" . a:firstline . ",+" . l:jf . "s/^ *\\zs".l:exr."\\ze.*$/".l:ex
endfunction
"コメントアウトアウト？
function! Ucom(...)
  let filenum = line("$") - line(".")
  let num = 0
  if a:0>0
    let num = a:1-1
    let filenum -= (a:1-1)
  endif
  let ex = expand("%:e")
  if filenum <= 0
    let num = line("$") - line(".")
  endif
  let exr = GetRegComMozi()
  if l:exr == ""
    return 0
  endif
  exec ":,+" . l:num . "s/^ *\\zs".l:exr."\\ze//"
endfunction
"引数の文字列はダブルクォーテーションマークをつけないといけない
"各拡張子に対応するコメントアウト文字を取得する
function! GetComMozi()
  let ex = expand("%:e")
  if l:ex == "c" || l:ex == "h" || l:ex == "cpp" || l:ex == "cxx" || l:ex == "hpp" || l:ex == "java" || l:ex == "cs" || l:ex == "php" || l:ex == "js"
    return "\\/\\/"
  elseif l:ex == "tex" || l:ex == "sty" || l:ex == "m"
    return "%"
  elseif l:ex == "py" || l:ex == "rb" || l:ex == "sh"
    return "#"
  elseif l:ex == "vim"
    return "\""
  else
    return ""
  endif
endfunction
function! GetComMoziNE()
  let ex = expand("%:e")
  if l:ex == "c" || l:ex == "h" || l:ex == "cpp" || l:ex == "cxx" || l:ex == "hpp" || l:ex == "java" || l:ex == "cs" || l:ex == "php" || l:ex == "js"
    return "\/\/"
  elseif l:ex == "tex" || l:ex == "sty" || l:ex == "m"
    return "%"
  elseif l:ex == "py" || l:ex == "rb" || l:ex == "sh"
    return "\#"
  elseif l:ex == "vim"
    return "\""
  else
    return ""
  endif
endfunction
"各拡張子に対応するコメントアウト文字を正規表現で取得する
function! GetRegComMozi()
  let ex = expand("%:e")
  if l:ex == "c" || l:ex == "h" || l:ex == "cpp" || l:ex == "cxx" || l:ex == "hpp" || l:ex == "java" || l:ex == "cs" || l:ex == "php" || l:ex == "js"
    return "\\/*"
  elseif l:ex == "tex" || l:ex == "sty" || l:ex == "m"
    return "%*"
  elseif l:ex == "py" || l:ex == "rb" || l:ex == "sh"
    return "#*"
  elseif l:ex == "vim"
    return "\"*"
  else
    return ""
  endif
endfunction
"すでにコメントアウトされている行か確認
"コメントアウトされている場合は1(true)"
function! IsCommentOut()
  let co = 1
  let ge = 0
  while 1
    if getline(".")[l:ge] != " "
      break
    endif
    let l:ge = l:ge + 1
  endwhile
  for n in range(strlen(GetComMoziNE()))
    let tmp = l:ge + n 
    if getline(".")[l:tmp] != GetComMoziNE()[n]
      let l:co = 0
      break
    endif
  endfor
  return l:co
endfunction
"コメントアウト実行"
function! SwitchCom()
  if a:lastline - a:firstline <=0
    if IsCommentOut() == 1
      exec ":call Ucom()"
    else
      exec ":call Com()"
    endif
  else
    exec "call Com()"
  endif
endfunction
"コメントアウトコマンドを定義
command! -nargs=? CommentOut call Com(<f-args>)
"Space+cでコメントアウト
"nnoremap <Space>f :CommentOut<CR>
"n<Spacs>cでn行分コメントアウト
"for n in range(1,300)
"  exec "nnoremap " . n . "<Space>f :CommentOut " . n ."<CR>"
"endfor
"コメントアウトアウトコマンドを定義
"command! -nargs=? UnCommentOut call Ucom(<f-args>)
command! -range -nargs=0 UnCommentOut <line1>,<line2> call Ucom()
"Space+Cでコメントアウトアウト
nnoremap <Space>F :UnCommentOut<CR>
vnoremap <Space>F :UnCommentOut<CR>
"n<Space>Cでn行分コメントアウトアウト
"for n in range(1,300)
  "exec "nnoremap " . n . "<Space>F :UnCommentOut " . n ."<CR>"
"endfor
"rangeの使い方がわかってない(range回繰り返してるだけ？)"
command! -range -nargs=0 SCO <line1>,<line2>call SwitchCom()
nnoremap <Space>f :SCO<CR>
vnoremap <Space>f :SCO<CR>
