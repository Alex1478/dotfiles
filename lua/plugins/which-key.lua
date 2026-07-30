return {
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      preset = "modern", -- optional, can be "modern" or "classic"
      triggers = {}, -- disable all auto-triggers; only show on demand via <leader>?
    },
    keys = {
      {
        "<leader>?",
        function()
          require("which-key").show({ global = false })
        end,
        desc = "Buffer Local Keymaps (which-key)",
      },
    },
  },
  {
    "echasnovski/mini.icons",
    version = false, -- always use latest
    config = function()
      require("mini.icons").setup()
    end,
  },
}
