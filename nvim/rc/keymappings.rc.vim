" This file contains the key mappings for Neovim

" 割り当て方として 連打したくなるようなやつ -> <C,Shift,Alt>+α , そうじゃないやつ -> [a-z,A-Z].*
let mapleader = "\<Space>"
inoremap <silent> jk <C-\><C-n>
tnoremap <silent> jk <C-\><C-n>
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
nnoremap w :wincmd w<CR>

nnoremap <leader>w :w <CR>
nnoremap <leader>q :q<CR>
nnoremap <leader>V :vs<CR>
nnoremap <leader><CR> :only<CR>
nnoremap <leader>H :sp<CR>
nnoremap <leader>t :tabnew <CR>
nnoremap <leader>e :e  
nnoremap <Tab><Tab> q:
" visualmodeでvを押すとカーソル以下の単語選択
vnoremap v iw
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
nmap <CR> <Nop>
" ノーマルモードでエンターを押すと改行できる
nnoremap <CR> za
"ジャンプ履歴を戻る 注：ジャンプ履歴はファイルを超えても飛んでいく
nnoremap <C-b> <C-o>
" ジャンプ履歴を進める <C-i>から始まる何かにあたってる
nnoremap <C-f> <C-i>
nmap H <C-u>
nmap L <C-d>

" カレントディレクトリ変更
" <C-p>はkと同じ
nmap <C-p> <Nop>
nnoremap <C-p> :cd:%:h "バッファまるごと開いてるファイルのディレクトリへ

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
