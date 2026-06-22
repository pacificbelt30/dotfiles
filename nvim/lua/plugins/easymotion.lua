-- vim-easymotion (旧 plugins/easymotion.rc.vim)
local g = vim.g
local map = vim.keymap.set

g.EasyMotion_do_mapping = 0
g.EasyMotion_skipfoldedline = 0
g.EasyMotion_smartcase = 1

-- map('', 'f', '<Plug>(easymotion-lineforward)', { remap = true })
-- map('', 'F', '<Plug>(easymotion-linebackward)', { remap = true })
map('', 'f', '<Plug>(easymotion-lineanywhere)', { remap = true })
-- map('', 'F', '<Plug>(easymotion-jumptoanywhere)', { remap = true })
-- map('', 'F', '<Plug>(easymotion-overwin-line)', { remap = true })
map('', 'F', '<Plug>(easymotion-overwin-f2)', { remap = true })
map('', '<leader>s', '<Plug>(easymotion-bd-f)', { remap = true })
map('n', '<leader>s', '<Plug>(easymotion-overwin-f)', { remap = true })
map('', '<leader>s', '<Plug>(easymotion-bd-f2)', { remap = true })
map('n', '<leader>s', '<Plug>(easymotion-overwin-f2)', { remap = true })
map('', '<leader>j', '<Plug>(easymotion-bd-jk)', { remap = true })
map('n', '<leader>j', '<Plug>(easymotion-overwin-line)', { remap = true })
map('', '<leader>r', '<Plug>(easymotion-bd-f)', { remap = true })
map('n', '<leader>r', '<Plug>(easymotion-overwin-f)', { remap = true })
-- map('', '/', '<Plug>(easymotion-sn)', { remap = true })
-- map('o', '/', '<Plug>(easymotion-tn)', { remap = true })
-- map('', 'n', '<Plug>(easymotion-next)', { remap = true })
-- map('', 'N', '<Plug>(easymotion-prev)', { remap = true })
