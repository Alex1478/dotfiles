return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    "nvim-tree/nvim-web-devicons",
  },
  lazy = false, -- neo-tree defers heavy work until you open it
  opts = {
    filesystem = {
      filtered_items = {
        always_show_by_pattern = { "Packages/**" },
        never_show = { ".DS_Store" },
      },
      follow_current_file = {
        enabled = true,          -- keep the tree synced to the active buffer
        leave_dirs_open = true, -- close auto expanded dirs when changing files
      },
    },
    window = {
      title = { enabled = true, text = "📁 Neo-tree" },
      mappings = {
        ["l"] = "open",
        ["Z"] = "expand_all_nodes",
        ["z"] = "close_all_nodes",
      },
    },
  },
  config = function(_, opts)
    require("neo-tree").setup(opts) -- make sure opts are applied
    local map = vim.keymap.set
    map("n", "<leader>E", "<cmd>Neotree toggle<cr>", { desc = "Neo-tree: Toggle" })
    map("n", "<leader>e", "<cmd>Neotree filesystem focus<cr>", { desc = "Neo-tree: Focus Files" })
  end,
}
