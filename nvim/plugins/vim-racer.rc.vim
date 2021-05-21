" vim-racerの設定
set hidden
let g:racer_cmd = 'racer'
let g:racer_experimental_completer = 1
[[plugins]]
repo = 'racer-rust/vim-racer'
hook_add = '''
source ~/.config/nvim/plugins/vim-racer.rc.vim
'''
