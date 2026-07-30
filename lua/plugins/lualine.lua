return {
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      sections = {
        lualine_x = {
          {
            function()
              local ok, tm = pcall(require, "swift.features.target_manager")
              if ok and vim.bo.filetype == "swift" then
                return tm.statusline_simple()
              end
              return ""
            end,
            icon = "󰛥",
            color = { fg = "#ff6b00" },
          },
          "encoding",
          "fileformat",
          "filetype",
        },
      },
    },
  },
}
