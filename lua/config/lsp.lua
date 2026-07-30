vim.lsp.enable('lua_ls')
vim.lsp.enable('sourcekit')
vim.lsp.enable('clangd')

vim.lsp.inlay_hint.enable(true)

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    vim.lsp.inlay_hint.enable(true, { bufnr = args.buf })
  end,
})

-- sourcekit-lsp (Swift) keymaps, moved here since swift.nvim's own LSP
-- feature is disabled (see lua/plugins/swift.lua) to avoid the deprecated
-- `require('lspconfig')` "framework" path.
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if not client or client.name ~= "sourcekit" then
      return
    end

    local opts = { buffer = args.buf, noremap = true, silent = true }
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
    vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
    vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
  end,
})

vim.lsp.config('clangd', {
  cmd = {
    'clangd',
    '--compile-commands-dir=build',   -- only if you put the json in build/
    '--background-index',
    '--clang-tidy',
  },
})

vim.diagnostic.config({
  virtual_text = true,     -- inline error text at end of line
  signs = true,            -- gutter markers
  underline = true,
  update_in_insert = false, -- diagnostics refresh on leaving insert; less noisy
})

-- Show full multi-line diagnostics below the current line
vim.diagnostic.config({
  virtual_lines = { current_line = true },
  virtual_text = false,
})
