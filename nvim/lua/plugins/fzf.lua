-- fzf / fzf.vim (旧 plugins/fzf.rc.vim)
local fn = vim.fn
local map = vim.keymap.set

-- fzf settings
vim.env.FZF_DEFAULT_OPTS = '--layout=reverse'
-- vim.env.FZF_DEFAULT_COMMAND = "rg --files --hidden --glob '!.git/**'"
-- vim.g.fzf_layout = { down = '~40%' }

local function find_git_root()
  -- プロジェクトルートで開く
  return fn.system('git rev-parse --show-toplevel 2> /dev/null'):sub(1, -2)
end

vim.api.nvim_create_user_command('ProjectFiles', function()
  vim.cmd('Files ' .. find_git_root())
end, {})

-- Filesコマンドにもプレビューを出す
vim.api.nvim_create_user_command('Files', function(o)
  fn['fzf#vim#files'](o.args, fn['fzf#vim#with_preview'](), o.bang and 1 or 0)
end, { bang = true, nargs = '?', complete = 'dir' })

-- GFilesはgitignore対象を非表示
vim.api.nvim_create_user_command('GitProjectFiles', function()
  vim.cmd('GFiles -oc --exclude-standard ' .. find_git_root())
end, {})

vim.api.nvim_create_user_command('GFiles', function(o)
  fn['fzf#vim#gitfiles'](o.args, fn['fzf#vim#with_preview'](), o.bang and 1 or 0)
end, { bang = true, nargs = '?', complete = 'dir' })

-- ripgrepで検索中、?を押すとプレビュー
vim.api.nvim_create_user_command('Rg', function(o)
  local preview = o.bang and fn['fzf#vim#with_preview']('up:60%')
    or fn['fzf#vim#with_preview']('right:50%:hidden', '?')
  fn['fzf#vim#grep'](
    'rg --column --line-number --no-heading --color=always --smart-case ' .. fn.shellescape(o.args),
    1,
    preview,
    o.bang and 1 or 0
  )
end, { bang = true, nargs = '*' })

-- preview付きBLines
vim.api.nvim_create_user_command('BLines', function(o)
  fn['fzf#vim#grep'](
    'rg --with-filename --column --line-number --no-heading --smart-case . ' .. fn.fnameescape(fn.expand('%:p')),
    1,
    fn['fzf#vim#with_preview']({
      options = '--layout reverse --query ' .. fn.shellescape(o.args) .. ' --with-nth=4.. --delimiter=":"',
    }, 'right:50%')
  )
end, { bang = true, nargs = '*' })

-- カーソル以下の単語取得
local function select_under_word()
  return fn.expand('<cword>')
end

-- カーソル以下の単語でfzf grep
local function asterisk_grep()
  fn['fzf#vim#grep'](
    'rg --with-filename --column --line-number --no-heading --smart-case . ' .. fn.fnameescape(fn.expand('%:p')),
    1,
    fn['fzf#vim#with_preview']({
      options = '--layout reverse --query '
        .. fn.shellescape(select_under_word() .. ' ')
        .. ' --with-nth=4.. --delimiter=":"',
    }, 'right:50%')
  )
end

-- map('n', '<leader>n', ':Files<CR>')
-- map('n', '<leader>n', ':ProjectFiles<CR>')
-- map('n', '<leader>n', ':GitProjectFiles<CR>')
-- map('n', '<leader>r', ':Rg ')
map('n', '<leader>b', ':Buffers<CR>')
map('n', '/', ':BLines<CR>', { remap = true })
map('n', '\\', ':Rg<CR>', { remap = true })
map('', '*', '<nop>', { remap = true })
map('n', '*', asterisk_grep)
map('n', '<leader>e', ':CocFzfList diagnostics<CR>')

-- gitレポジトリがある場合はGFiles,ない場合はFilesを使う
if find_git_root() == '' then
  map('n', '<leader>n', ':ProjectFiles<CR>')
else
  map('n', '<leader>n', ':GitProjectFiles<CR>')
end

-- fzfターミナル上でのキーマップ
local fzf_grp = vim.api.nvim_create_augroup('_fzf_', { clear = true })
vim.api.nvim_create_autocmd('FileType', {
  group = fzf_grp,
  pattern = 'fzf',
  callback = function(ev)
    vim.opt_local.winblend = 15
    local o = { buffer = ev.buf }
    vim.keymap.set('n', 'q', ':q<CR>', o)
    vim.keymap.set('t', '<Esc>', [[<C-\><C-n>:q<CR>]], o)
    vim.keymap.set('t', 'jj', [[<C-\><C-n>:q<CR>]], o)
    vim.keymap.set('t', '<Space><Space>', '<C-u>', o)
  end,
})
