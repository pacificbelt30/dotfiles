" 割り当て方として 連打したくなるようなやつ -> <C,Shift,Alt>+α , そうじゃないやつ -> [a-z,A-Z].*
let mapleader = "\<Space>"
inoremap <silent> jj <C-\><C-n>
tnoremap <silent> jj <C-\><C-n>
inoremap <silent> jk <C-\><C-n>
tnoremap <silent> jk <C-\><C-n>
"cnoremap <silent> jj <ESC>
"cnoremap <silent> jk <ESC>
nnoremap <silent> p p`]

nmap <Esc><Esc> :nohlsearch<CR><Esc>

nnoremap <silent> <C-j> :bprev<CR>
nnoremap <silent> <C-k> :bnext<CR>
tnoremap <Esc> <C-\><C-n>
tnoremap <a> <i>

nnoremap j gj
nnoremap k gk
vnoremap j gj
vnoremap k gk

" ウィンドウ移動
"nnoremap <C-w> :wincmd w<CR>
nnoremap w :wincmd w<CR>

nnoremap <leader>w :w <CR>
nnoremap <leader>q :q<CR>
nnoremap <leader>V :vs<CR>
nnoremap <leader><CR> :only<CR>
nnoremap <leader>H :sp<CR>
nnoremap <leader>t :tabnew <CR>
"nnoremap <leader><CR> :tabclose <CR>
"nnoremap <leader>b :b  
nnoremap <leader>e :e  
nnoremap <Tab><Tab> q:
" visualmodeでvを押すとカーソル以下の単語選択
vnoremap v iw
"nnoremap <leader>n :Ex.<CR>
"nnoremap <silent>bb :b#<CR>
"nnoremap <silent>bd :bd<CR>
" スペース二回でコマンドラインの入力消去 (ctrl+uのショートカットが有効の場合)
tnoremap <Space><Space> <C-u>
cnoremap <Space><Space> <C-u>
"オペレータ待機
onoremap 8 i(
onoremap 2 i"
onoremap 7 i'
onoremap @ i`
onoremap [ i[
onoremap { i{
onoremap , i<
nnoremap ; :
"nnoremap : ;
nmap <CR> <Nop>
" ノーマルモードでエンターを押すと改行できる
nnoremap <CR> o<Esc>
"nnoremap gb g; " 変更履歴を戻る 注：変更履歴はファイル間のジャンプはなし?
"nnoremap gf g. " 変更履歴を進める gfはカーソル下のファイルを開く
"ジャンプ履歴を戻る 注：ジャンプ履歴はファイルを超えても飛んでいく
nnoremap <C-b> <C-o>
" ジャンプ履歴を進める <C-i>から始まる何かにあたってる
nnoremap <C-f> <C-i>
nmap H <C-u>
nmap L <C-d>

"inoremap {<Enter> {}<Left><CR><ESC><S-o>
"inoremap [<Enter> []<Left><CR><ESC><S-o>
"inoremap (<Enter> ()<Left><CR><ESC><S-o>

" カレントディレクトリ変更
" <C-p>はkと同じ
nmap <C-p> <Nop>
nnoremap <C-p> :cd:%:h "バッファまるごと開いてるファイルのディレクトリへ
"nnoremap <C-p> :lcd:%:h " 現在のバッファのみディレクトリを変更

" インサートモードでjを打ったときの待ち時間を短縮(ターミナル，コマンドライン入力も)
augroup timeout
  autocmd!
  autocmd InsertEnter * set timeoutlen=300
  autocmd InsertLeave * set timeoutlen=1000
  autocmd TermEnter * set timeoutlen=300
  autocmd TermLeave * set timeoutlen=1000
  autocmd CmdlineEnter * set timeoutlen=300
  autocmd CmdlineLeave * set timeoutlen=1000
augroup END

