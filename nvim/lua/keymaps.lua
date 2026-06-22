-- キーマッピング (旧 rc/keymappings.rc.vim)
-- 割り当て方として 連打したくなるようなやつ -> <C,Shift,Alt>+α , そうじゃないやつ -> [a-z,A-Z].*
-- mapleader は init.lua で設定済み
local map = vim.keymap.set

-- inoremap <silent> jj <C-\><C-n>
-- tnoremap <silent> jj <C-\><C-n>
map('i', 'jk', [[<C-\><C-n>]], { silent = true })
map('t', 'jk', [[<C-\><C-n>]], { silent = true })
map('n', 'p', 'p`]', { silent = true })

map('n', '<Esc><Esc>', ':nohlsearch<CR><Esc>', { remap = true })

map('n', '<C-j>', ':bprev<CR>', { silent = true })
map('n', '<C-k>', ':bnext<CR>', { silent = true })
map('t', '<Esc>', [[<C-\><C-n>]])
map('t', '<a>', '<i>')

map('n', 'j', 'gj')
map('n', 'k', 'gk')
map('v', 'j', 'gj')
map('v', 'k', 'gk')

-- ウィンドウ移動
-- map('n', '<C-w>', ':wincmd w<CR>')
map('n', 'w', ':wincmd w<CR>')

map('n', '<leader>w', ':w<CR>')
map('n', '<leader>q', ':q<CR>')
map('n', '<leader>V', ':vs<CR>')
map('n', '<leader><CR>', ':only<CR>')
map('n', '<leader>H', ':sp<CR>')
map('n', '<leader>t', ':tabnew<CR>')
-- map('n', '<leader><CR>', ':tabclose<CR>')
-- map('n', '<leader>b', ':b ')
map('n', '<leader>e', ':e ')
map('n', '<Tab><Tab>', 'q:')
-- visualmodeでvを押すとカーソル以下の単語選択
map('v', 'v', 'iw')
-- map('n', '<leader>n', ':Ex.<CR>')
-- map('n', 'bb', ':b#<CR>', { silent = true })
-- map('n', 'bd', ':bd<CR>', { silent = true })
-- スペース二回でコマンドラインの入力消去 (ctrl+uのショートカットが有効の場合)
map('t', '<Space><Space>', '<C-u>')
map('c', '<Space><Space>', '<C-u>')
-- オペレータ待機
map('o', '8', 'i(')
map('o', '2', 'i"')
map('o', '7', "i'")
map('o', '@', 'i`')
map('o', '[', 'i[')
map('o', '{', 'i{')
map('o', ',', 'i<')
map('n', ';', ':')
-- map('n', ':', ';')
-- ノーマルモードでエンターを押すと折りたたみ開閉 (旧 nmap <CR> <Nop> は za で上書きされていた)
map('n', '<CR>', 'za')
-- ジャンプ履歴を戻る 注：ジャンプ履歴はファイルを超えても飛んでいく
map('n', '<C-b>', '<C-o>')
-- ジャンプ履歴を進める
map('n', '<C-f>', '<C-i>')
map('n', 'H', '<C-u>', { remap = true })
map('n', 'L', '<C-d>', { remap = true })

-- inoremap {<Enter> {}<Left><CR><ESC><S-o>
-- inoremap [<Enter> []<Left><CR><ESC><S-o>
-- inoremap (<Enter> ()<Left><CR><ESC><S-o>

-- カレントディレクトリ変更 (バッファまるごと開いてるファイルのディレクトリへ)
map('n', '<C-p>', ':cd %:h<CR>', { silent = true })
-- map('n', '<C-p>', ':lcd %:h<CR>') -- 現在のバッファのみディレクトリを変更

-- インサートモードでjを打ったときの待ち時間を短縮(ターミナル，コマンドライン入力も)
local timeout = vim.api.nvim_create_augroup('timeout', { clear = true })
local function set_timeoutlen(events, len)
  vim.api.nvim_create_autocmd(events, {
    group = timeout,
    callback = function()
      vim.o.timeoutlen = len
    end,
  })
end
set_timeoutlen('InsertEnter', 300)
set_timeoutlen('InsertLeave', 1000)
set_timeoutlen('TermEnter', 300)
set_timeoutlen('TermLeave', 1000)
set_timeoutlen('CmdlineEnter', 300)
set_timeoutlen('CmdlineLeave', 1000)
