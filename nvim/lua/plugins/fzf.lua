-- fzf-lua (旧 fzf.vim / denite から移行)
local fzf = require('fzf-lua')
local map = vim.keymap.set

fzf.setup({
  'default',
  winopts = {
    preview = {
      layout = 'flex',
    },
  },
})

-- git リポジトリ内なら git_files、そうでなければ files
local function project_files()
  local in_git = vim.fn.system('git rev-parse --is-inside-work-tree 2> /dev/null')
  if vim.v.shell_error == 0 and in_git:match('true') then
    fzf.git_files()
  else
    fzf.files()
  end
end

-- ファイル検索 (旧 :ProjectFiles / :GitProjectFiles, denite file/rec)
map('n', '<leader>n', project_files, { desc = 'fzf: project files' })
map('n', '<Space>d', fzf.files, { desc = 'fzf: files' })
-- バッファ一覧
map('n', '<leader>b', fzf.buffers, { desc = 'fzf: buffers' })
-- プロジェクト全体を grep (旧 :Rg, denite grep)
map('n', '\\', fzf.live_grep, { remap = true, desc = 'fzf: live grep' })
map('n', '<Space>g', fzf.live_grep, { desc = 'fzf: live grep' })
-- 現在バッファ内を fuzzy 検索 (旧 :BLines)
map('n', '/', fzf.lgrep_curbuf, { remap = true, desc = 'fzf: search current buffer' })
-- カーソル下の単語で現在バッファを grep (旧 asterisk_grep)
map('', '*', '<nop>', { remap = true })
map('n', '*', function()
  fzf.grep_curbuf({ search = vim.fn.expand('<cword>') })
end, { desc = 'fzf: grep word under cursor in buffer' })
-- 診断一覧 (旧 :CocFzfList diagnostics)
map('n', '<leader>e', fzf.diagnostics_document, { desc = 'fzf: diagnostics' })
