-- Horizontal and Vertical Splits
vim.keymap.set('n', '<leader>h', ':split<CR>', { desc = 'Horizontal Split' })
vim.keymap.set('n', '<leader>v', ':vsplit<CR>', { desc = 'Vertical Split' })

-- Move between Splits
vim.keymap.set({ 'n', }, '<C-h>', ':wincmd h<CR>', { desc = 'Goto Left Window', silent = true })
vim.keymap.set({ 'n', }, '<C-j>', ':wincmd j<CR>', { desc = 'Goto Below Window', silent = true })
vim.keymap.set({ 'n', }, '<C-k>', ':wincmd k<CR>', { desc = 'Goto Above Window', silent = true })
vim.keymap.set({ 'n', }, '<C-l>', ':wincmd l<CR>', { desc = 'Goto Right Window', silent = true })

vim.keymap.set({ 'n', 't' }, '<S-Right>', ':vertical res +1^M<CR>', { silent = true })
vim.keymap.set({ 'n', 't' }, '<S-Left>', ':vertical res -1^M<CR>', { silent = true })
vim.keymap.set({ 'n', 't' }, '<S-Up>', ':resize -1<CR>', { silent = true })
vim.keymap.set({ 'n', 't' }, '<S-Down>', ':resize +1<CR>', { silent = true })

-- Buffer navigation and management
vim.keymap.set('n', '<C-left>', ':bprev<CR>', { desc = 'Goto Previous Buffer', silent = true })
vim.keymap.set('n', '<C-right>', ':bnext<CR>', { desc = 'Goto Next Buffer', silent = true })
vim.keymap.set('n', '<leader>cb', ':bprev<CR>:bdelete #<CR>', { desc = 'Close Current Buffer' })
vim.keymap.set('n', '<leader>cB', "<cmd>:%bd<CR>", { desc = 'Close All Buffers' })
vim.keymap.set('n', '<leader>rb', "<cmd>:e!<CR>", { desc = 'Reload Buffer' })