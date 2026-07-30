-- Seamless navigation between Neovim splits and tmux panes with the same
-- keys (<C-h/j/k/l>), so switching focus feels identical whether the
-- adjacent pane is another Neovim split or a tmux pane (e.g. lazygit).
return {
  'christoomey/vim-tmux-navigator',
  lazy = false,
  init = function()
    vim.g.tmux_navigator_no_mappings = 1
  end,
  config = function()
    local opts = { silent = true }
    vim.keymap.set('n', '<C-h>', '<cmd>TmuxNavigateLeft<CR>', opts)
    vim.keymap.set('n', '<C-j>', '<cmd>TmuxNavigateDown<CR>', opts)
    vim.keymap.set('n', '<C-k>', '<cmd>TmuxNavigateUp<CR>', opts)
    vim.keymap.set('n', '<C-l>', '<cmd>TmuxNavigateRight<CR>', opts)

    vim.keymap.set('t', '<C-h>', [[<C-\><C-n>:TmuxNavigateLeft<CR>]], opts)
    vim.keymap.set('t', '<C-j>', [[<C-\><C-n>:TmuxNavigateDown<CR>]], opts)
    vim.keymap.set('t', '<C-k>', [[<C-\><C-n>:TmuxNavigateUp<CR>]], opts)
    vim.keymap.set('t', '<C-l>', [[<C-\><C-n>:TmuxNavigateRight<CR>]], opts)
  end,
}
