return {
  {
    "akinsho/git-conflict.nvim",
    -- TODO: remove patch once upstream fixes vim.diagnostic API for Neovim 0.12
    -- Patched: ~/.local/share/nvim/lazy/git-conflict.nvim/lua/git-conflict.lua lines 652, 662
    version = "*",
    config = function()
      require("git-conflict").setup({
        default_mappings = true,
        disable_diagnostics = true,
        list_opener = "copen",
        highlights = {
          current = "DiffAdd",
          incoming = "DiffChange",
        },
        debug = false,
      })
    end,
  },
  {
    "sindrets/diffview.nvim",
    config = function()
      require("diffview").setup({
        enhanced_diff_hl = true,
        view = {
          merge_tool = {
            layout = "diff3_mixed", -- 3-way split
            disable_diagnostics = true,
          },
        },
      })
      -- Optional keymaps
      vim.keymap.set("n", "<leader>jo", ":DiffviewOpen<CR>", { desc = "Git open Diffview" })
      vim.keymap.set("n", "<leader>jc", ":DiffviewClose<CR>", { desc = "Git close Diffview" })
    end,
  },
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require('gitsigns').setup()
      vim.keymap.set("n", "<leader>jp", ":Gitsigns preview_hunk<CR>", { desc = "Git preview hunk" })
      vim.keymap.set("n", "<leader>jt", ":Gitsigns toggle_current_line_blame<CR>", { desc = "Git toggle current line blame" })
    end
  },
}
