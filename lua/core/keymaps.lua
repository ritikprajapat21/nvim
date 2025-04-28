-- Keymaps for better default experience
-- Set leader key
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- For conciseness
local opts = { noremap = true, silent = true }

function map(mode, lhs, rhs, desc)
    vim.keymap.set(mode, lhs, rhs, {noremap = true, silent = true, desc = desc })
end

-- Allow moving the cursor through wrapped lines with j, k
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- clear highlights
map('n', '<Esc>', ':noh<CR>', "No highlight")

-- save file
map({'n', 'i', 'v'}, '<C-s>', '<cmd> w <CR>', "Save file")

-- save file without auto-formatting
map('n', '<leader>sn', '<cmd>noautocmd w <CR>', "Save without autoformat")

-- quit file
-- map('n', '<C-q>', '<cmd> q <CR>', "Quit file")

-- delete single character without copying into register
map('n', 'x', '"_x', "Delete char without copying into register")

-- Vertical scroll and center
map('n', '<C-d>', '<C-d>zz', "Scroll down and center cursor")
map('n', '<C-u>', '<C-u>zz', "Scroll up and center cursor")

-- Find and center
map('n', 'n', 'nzzzv', "Find next and center")
map('n', 'N', 'Nzzzv', "Find previous and center")

-- Resize with arrows
-- map('n', '<Up>', ':resize -2<CR>', opts)
-- map('n', '<Down>', ':resize +2<CR>', opts)
-- map('n', '<Left>', ':vertical resize -2<CR>', opts)
-- map('n', '<Right>', ':vertical resize +2<CR>', opts)

-- Buffers
map('n', '<Tab>', ':bnext<CR>', "Next buffer")
map('n', '<S-Tab>', ':bprevious<CR>', "Previous buffer")
map('n', '<leader>x', ':bdelete!<CR>', "Delete buffer")   -- close buffer
map('n', '<leader>b', '<cmd> enew <CR>', "Create buffer") -- new buffer

-- Increment/decrement numbers
map('n', '<leader>+', '<C-a>', "Increment") -- increment
map('n', '<leader>-', '<C-x>', "Decrement") -- decrement

-- Window management
map('n', '<leader>v', '<C-w>v', "Vertical split")      -- split window vertically
map('n', '<leader>h', '<C-w>s', "Horizontal split")      -- split window horizontally
map('n', '<leader>se', '<C-w>=', "Equal split")     -- make split windows equal width & height
map('n', '<leader>xs', ':close<CR>', "Close split") -- close current split window

-- Navigate between splits
map('n', '<C-k>', ':wincmd k<CR>', "Go to prev pane")
map('n', '<C-j>', ':wincmd j<CR>', "Go to next pane")
map('n', '<C-h>', ':wincmd h<CR>', "Go to below pane")
map('n', '<C-l>', ':wincmd l<CR>', "Go to above pane")

-- Tabs
map('n', '<leader>to', ':tabnew<CR>', "Create new tab")   -- open new tab
map('n', '<leader>tx', ':tabclose<CR>', "Close tab") -- close current tab
map('n', '<leader>tn', ':tabn<CR>', "Go to next tab")     --  go to next tab
map('n', '<leader>tp', ':tabp<CR>', "Go to prev tab")     --  go to previous tab

-- Toggle line wrapping
map('n', '<leader>lw', '<cmd>set wrap!<CR>', "Toggle line wrap")

-- Press jk fast to exit insert mode
map('i', 'jk', '<ESC>', "Exit from insert mode")

-- Stay in indent mode
map('v', '<', '<gv', "Indent leftward")
map('v', '>', '>gv', "Indent rightward")

-- Move text up and down
map('v', '<A-j>', ':m .+1<CR>==', "Move line upward")
map('v', '<A-k>', ':m .-2<CR>==', "Move line downward")

-- Keep last yanked when pasting
map('v', 'p', '"_dP', "Keep last yanked when pasting")

-- Replace word under cursor
map('n', '<leader>j', '*``cgn', "Replace word under cursor")

-- Explicitly yank to system clipboard (highlighted and entire row)
map({ 'n', 'v' }, '<leader>y', [["+y]], "Yank to system clipboard")
map('n', '<leader>Y', [["+Y]], "Yank to system clipboard")

-- Toggle diagnostics
local diagnostics_active = true

map('n', '<leader>do', function()
  diagnostics_active = not diagnostics_active

  if diagnostics_active then
    vim.diagnostic.enable(true)
  else
    vim.diagnostic.enable(false)
  end
end, "Toggle diagnostics")

-- Diagnostic keymaps
map('n', '[d', vim.diagnostic.goto_prev,  'Go to previous diagnostic message' )
map('n', ']d', vim.diagnostic.goto_next, 'Go to next diagnostic message' )
map('n', 'gl', vim.diagnostic.open_float, 'Open floating diagnostic message' )
map('n', '<leader>q', vim.diagnostic.setloclist, 'Open diagnostics list' )

-- Save and load session
vim.keymap.set('n', '<leader>ss', ':mksession! .session.vim<CR>', { noremap = true, silent = false })
vim.keymap.set('n', '<leader>sl', ':source .session.vim<CR>', { noremap = true, silent = false })
