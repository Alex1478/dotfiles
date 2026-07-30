vim.keymap.set({ 'n', 'x' }, 'j', 'gj', { desc = 'Navigate down (visual line)' })
vim.keymap.set({ 'n', 'x' }, 'k', 'gk', { desc = 'Navigate up (visual line)' })
vim.keymap.set({ 'n', 'x' }, '<Down>', 'gj', { desc = 'Navigate down (visual line)' })
vim.keymap.set({ 'n', 'x' }, '<Up>', 'gk', { desc = 'Navigate up (visual line)' })
vim.keymap.set('i', '<Down>', '<C-\\><C-o>gj', { desc = 'Navigate down (visual line)' })
vim.keymap.set('i', '<Up>', '<C-\\><C-o>gk', { desc = 'Navigate up (visual line)' })

-- Move current line down / up with Alt-j / Alt-k in Normal mode
-- (moved off <C-j>/<C-k> to free those for vim-tmux-navigator pane navigation)
vim.keymap.set("n", "<A-k>", ":m .-2<CR>==", { desc = "Move line up" })
vim.keymap.set("n", "<A-j>", ":m .+1<CR>==", { desc = "Move line down" })

-- And in Visual mode, to move a whole selected block
vim.keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv", { desc = "Move block up" })
vim.keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv", { desc = "Move block down" })

-- Easier interaction with the system clipboard
vim.keymap.set({ 'n', 'x' }, '<leader>y', '"+y', { desc = 'Copy to system clipboard' })
vim.keymap.set({ 'n', 'x' }, '<leader>p', '"+p', { desc = 'Paste from system clipboard after the cursor position' })
vim.keymap.set({ 'n', 'x' }, '<leader>P', '"+P', { desc = 'Paste from system clipboard before the cursor position' })

-- Navigating buffers
vim.keymap.set('n', '<leader>bb', '<C-^>', { desc = 'Switch to alternate buffer' })
vim.keymap.set('n', '<leader>bn', ':bnext<cr>', { desc = 'Next buffer' })
vim.keymap.set('n', '<leader>bp', ':bprevious<cr>', { desc = 'Previous buffer' })

-- Toggle search highlighting (moved off <C-l> to free it for vim-tmux-navigator)
vim.keymap.set('n', '<leader>/', ':set hlsearch!<cr><C-l>', { desc = 'Toggle search highlighting' })

-- Toggle visible whitespace characters
vim.keymap.set('n', '<leader>l', ':listchars!<cr>', { desc = 'Toggle [l]istchars' })

-- Split
vim.keymap.set('n', '|', ':vsplit<CR>', { desc = 'vertical split', silent = true })
vim.keymap.set('n', '_', ':split<CR>',   { desc = 'horizontal split', silent = true })
-- Split/pane navigation (<C-h/j/k/l>) is handled by vim-tmux-navigator (see
-- lua/plugins/vim-tmux-navigator.lua), which also seamlessly moves between
-- tmux panes when at the edge of the Neovim window.

vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>', { desc = 'Clear search highlight' })

vim.keymap.set('n', '<C-Up>', ':resize -2<CR>', { desc = 'Decrease height', silent = true })
vim.keymap.set('n', '<C-Down>', ':resize +2<CR>', { desc = 'Increase height', silent = true })
vim.keymap.set('n', '<C-Left>', ':vertical resize -2<CR>', { desc = 'Decrease width', silent = true })
vim.keymap.set('n', '<C-Right>', ':vertical resize +2<CR>', { desc = 'Increase width', silent = true})

-- escape insert mode without having to type escape
vim.keymap.set('i', 'jj', '<Esc>', { desc = 'Exit insert mode' })

-- format the file
vim.keymap.set("n", "=", function()
    vim.lsp.buf.format({ async = true })
end, { desc = "Format file" })

-- LSP rename
vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { desc = "LSP rename" })

-- LSP code action
vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "LSP code action" })

-- Switch between header/source (clangd)
vim.keymap.set("n", "<leader>sh", function()
  vim.lsp.buf_request(0, 'textDocument/clangd.switchSourceHeader',
    vim.lsp.util.make_text_document_params(0),
    function(err, result)
      if result then vim.cmd('edit ' .. vim.uri_to_fname(result)) end
    end)
end, { desc = "Switch header/source" })

-- DAP (debugger)
vim.keymap.set("n", "<leader>dc", function() require("dap").continue() end,           { desc = "DAP continue" })
vim.keymap.set("n", "<leader>dn", function() require("dap").step_over() end,          { desc = "DAP step over" })
vim.keymap.set("n", "<leader>di", function() require("dap").step_into() end,          { desc = "DAP step into" })
vim.keymap.set("n", "<leader>do", function() require("dap").step_out() end,           { desc = "DAP step out" })
vim.keymap.set("n", "<leader>db", function() require("dap").toggle_breakpoint() end,  { desc = "DAP toggle breakpoint" })
vim.keymap.set("n", "<leader>dt", function() require("dap").terminate() end,          { desc = "DAP terminate" })
vim.keymap.set("n", "<leader>du", function() require("dapui").toggle() end,           { desc = "DAP toggle UI" })
