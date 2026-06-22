-- denite.nvim (旧 plugins/denite.rc.vim)
local fn = vim.fn

-- Define mappings
local function denite_my_settings()
  local opts = { noremap = true, silent = true, expr = true, buffer = true }
  vim.keymap.set('n', '<CR>', function()
    return fn['denite#do_map']('do_action')
  end, opts)
  vim.keymap.set('n', 'd', function()
    return fn['denite#do_map']('do_action', 'delete')
  end, opts)
  vim.keymap.set('n', 'p', function()
    return fn['denite#do_map']('do_action', 'preview')
  end, opts)
  vim.keymap.set('n', 'q', function()
    return fn['denite#do_map']('quit')
  end, opts)
  vim.keymap.set('n', 'i', function()
    return fn['denite#do_map']('open_filter_buffer')
  end, opts)
  vim.keymap.set('n', '<Space>', function()
    return fn['denite#do_map']('toggle_select') .. 'j'
  end, opts)
end

vim.api.nvim_create_autocmd('FileType', {
  pattern = 'denite',
  callback = denite_my_settings,
})

vim.keymap.set('n', '<Space>d', ':Denite file/rec<CR>', { silent = true })
-- vim.keymap.set('n', '<Space>b', ':Denite buffer<CR>', { silent = true })
vim.keymap.set('n', '<Space>g', ':Denite grep<CR>', { silent = true })

local win_width_percent = 0.7
local win_height_percent = 0.5
local columns = vim.o.columns
local lines = vim.o.lines
local denite_default_options = {
  split = 'floating',
  winwidth = math.floor(columns * win_width_percent),
  wincol = math.floor((columns - (columns * win_width_percent)) / 2),
  winheight = math.floor(lines * win_height_percent),
  winrow = math.floor((lines - (lines * win_height_percent)) / 2),
  highlight_filter_background = 'DeniteFilter',
  prompt = '$ ',
  start_filter = false,
}
fn['denite#custom#option']('default', denite_default_options)

-- Ripgrep command on grep source
fn['denite#custom#var']('grep', 'command', { 'rg' })
fn['denite#custom#var']('grep', 'default_opts', { '-i', '--vimgrep', '--no-heading' })
fn['denite#custom#var']('grep', 'recursive_opts', {})
fn['denite#custom#var']('grep', 'pattern_opt', { '--regexp' })
fn['denite#custom#var']('grep', 'separator', { '--' })
fn['denite#custom#var']('grep', 'final_opts', {})
