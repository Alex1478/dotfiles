-- ╔══════════════════════════════════════════════════════════════════════════════╗
-- ║                  CONFIGURACIÓN COMPLETA DE SWIFT.NVIM                        ║
-- ║                                                                              ║
-- ║  Incluye TODAS las features: LSP, Formatter, Linter, Build, Debug,          ║
-- ║  Snippets, Xcode, Target Manager, Version Validation                        ║
-- ╚══════════════════════════════════════════════════════════════════════════════╝

return {
  {
    "devswiftzone/swift.nvim",
    ft = "swift", -- Carga solo para archivos Swift
    dependencies = {
      -- Solo si ya tienes estos plugins instalados, sino swift.nvim funciona sin ellos
      -- "neovim/nvim-lspconfig",        -- Opcional: para LSP
      -- "hrsh7th/nvim-cmp",             -- Opcional: para completions
      -- "L3MON4D3/LuaSnip",             -- Opcional: para snippets
    },

    opts = {
      -- ═══════════════════════════════════════════════════════════════════════════
      -- CARACTERÍSTICAS PRINCIPALES
      -- ═══════════════════════════════════════════════════════════════════════════

      features = {
        -- ─────────────────────────────────────────────────────────────────────────
        -- 📡 LSP (Language Server Protocol)
        -- ─────────────────────────────────────────────────────────────────────────
        lsp = {
          -- Disabled: sourcekit-lsp is configured natively via vim.lsp.enable('sourcekit')
          -- in lua/config/lsp.lua (Neovim >= 0.11 API). Letting swift.nvim manage it too
          -- would go through the deprecated `require('lspconfig')` "framework" and conflict
          -- with the native client. See lua/config/lsp.lua for the sourcekit on_attach keymaps.
          enabled = false,
          auto_setup = false,
        },

        -- ─────────────────────────────────────────────────────────────────────────
        -- 💅 FORMATTER (swift-format / swiftformat)
        -- ─────────────────────────────────────────────────────────────────────────
        formatter = {
          enabled = true,
          auto_format = false, -- true = formatear al guardar automáticamente
          format_on_save = false, -- Alias de auto_format
          tool = "swift-format", -- "swift-format" o "swiftformat"

          -- Opciones de swift-format
          swift_format = {
            path = nil, -- nil = auto-detect
            args = {}, -- Argumentos adicionales
            config_file = nil, -- Path a .swift-format (nil = buscar en proyecto)
          },

          -- Opciones de swiftformat
          swiftformat = {
            path = nil, -- nil = auto-detect
            args = {}, -- Argumentos adicionales
            config_file = nil, -- Path a .swiftformat (nil = buscar en proyecto)
          },
        },

        -- ─────────────────────────────────────────────────────────────────────────
        -- 🔍 LINTER (SwiftLint)
        -- ─────────────────────────────────────────────────────────────────────────
        linter = {
          enabled = true,
          auto_lint = true, -- Lint automático al guardar
          swiftlint_path = nil, -- nil = auto-detect
          config_file = nil, -- Path a .swiftlint.yml (nil = buscar en proyecto)
          severity = "warning", -- "error" o "warning"
        },

        -- ─────────────────────────────────────────────────────────────────────────
        -- 🔨 BUILD RUNNER
        -- ─────────────────────────────────────────────────────────────────────────
        build_runner = {
          enabled = true,
          show_output = true, -- Mostrar ventana de output
          output_position = "botright", -- Posición de la ventana
          output_height = 15, -- Altura de la ventana
          auto_close_on_success = false, -- Cerrar ventana si build exitoso
        },

        -- ─────────────────────────────────────────────────────────────────────────
        -- 🎯 TARGET MANAGER
        -- ─────────────────────────────────────────────────────────────────────────
        target_manager = {
          enabled = true,
          auto_select = true, -- Auto-seleccionar primer target ejecutable
          show_type = true, -- Mostrar tipo de target (executable, library, test)
        },

        -- ─────────────────────────────────────────────────────────────────────────
        -- 🐛 DEBUGGER (LLDB Directo - SIN nvim-dap)
        -- ─────────────────────────────────────────────────────────────────────────
        debugger = {
          enabled = true,
          lldb_path = nil, -- nil = auto-detect LLDB

          -- Símbolos visuales
          signs = {
            breakpoint = "●", -- Símbolo para breakpoints
            current_line = "➤", -- Símbolo para línea actual durante debug
          },

          -- Colores (usa highlight groups de Neovim)
          colors = {
            breakpoint = "DiagnosticError", -- Rojo para breakpoints
            current_line = "DiagnosticInfo", -- Azul para línea actual
          },

          -- Ventana de debug output
          window = {
            position = "bottom", -- "bottom", "right", o "float"
            size = 15, -- Altura para bottom, anchura para right
          },
        },

        -- ─────────────────────────────────────────────────────────────────────────
        -- 📝 SNIPPETS (50+ snippets de Swift)
        -- ─────────────────────────────────────────────────────────────────────────
        snippets = {
          enabled = true, -- Requiere LuaSnip instalado
        },

        -- ─────────────────────────────────────────────────────────────────────────
        -- 🍎 XCODE INTEGRATION (solo macOS)
        -- ─────────────────────────────────────────────────────────────────────────
        xcode = {
          enabled = vim.fn.has("mac") == 1, -- Auto-detectar macOS
          default_scheme = nil, -- nil = pedir al usuario
          default_simulator = nil, -- nil = pedir al usuario
          show_output = true,
          output_position = "botright",
          output_height = 15,
        },

        -- ─────────────────────────────────────────────────────────────────────────
        -- 📁 PROJECT DETECTOR (auto-detecta SPM/Xcode)
        -- ─────────────────────────────────────────────────────────────────────────
        project_detector = {
          enabled = true,
        },

        -- ─────────────────────────────────────────────────────────────────────────
        -- ✅ VERSION VALIDATOR (valida versión de Swift)
        -- ─────────────────────────────────────────────────────────────────────────
        version_validator = {
          enabled = true,
          show_warnings = true, -- Mostrar warnings de versión
        },
      },

      -- ═══════════════════════════════════════════════════════════════════════════
      -- CONFIGURACIÓN GENERAL
      -- ═══════════════════════════════════════════════════════════════════════════

      -- Nivel de logging
      log_level = "info", -- "debug", "info", "warn", "error"

      -- Path al log file (para debugging del plugin)
      -- log_file = vim.fn.stdpath("cache") .. "/swift.nvim.log",
    },

    -- ═══════════════════════════════════════════════════════════════════════════
    -- CONFIGURACIÓN POST-SETUP
    -- ═══════════════════════════════════════════════════════════════════════════

    config = function(_, opts)
      -- Setup del plugin
      require("swift").setup(opts)

      -- ╔════════════════════════════════════════════════════════════════════════╗
      -- ║                          KEYBINDINGS GLOBALES                          ║
      -- ╚════════════════════════════════════════════════════════════════════════╝

      -- ─────────────────────────────────────────────────────────────────────────
      -- 🐛 DEBUGGER KEYBINDINGS
      -- ─────────────────────────────────────────────────────────────────────────

      local debugger = require("swift.features.debugger")

      -- Teclas F (estándar de debuggers)
      vim.keymap.set("n", "<F5>", debugger.continue, {
        desc = "Debug: Continue/Run",
        silent = true,
      })

      vim.keymap.set("n", "<F9>", debugger.toggle_breakpoint, {
        desc = "Debug: Toggle Breakpoint",
        silent = true,
      })

      vim.keymap.set("n", "<F10>", debugger.step_over, {
        desc = "Debug: Step Over",
        silent = true,
      })

      vim.keymap.set("n", "<F11>", debugger.step_into, {
        desc = "Debug: Step Into",
        silent = true,
      })

      vim.keymap.set("n", "<F12>", debugger.step_out, {
        desc = "Debug: Step Out",
        silent = true,
      })

      -- <leader>d para debug (más descriptivo)
      vim.keymap.set("n", "<leader>db", debugger.toggle_breakpoint, {
        desc = "Debug: Toggle Breakpoint",
      })

      vim.keymap.set("n", "<leader>dB", debugger.clear_breakpoints, {
        desc = "Debug: Clear All Breakpoints",
      })

      vim.keymap.set("n", "<leader>dc", debugger.continue, {
        desc = "Debug: Continue",
      })

      vim.keymap.set("n", "<leader>ds", debugger.stop, {
        desc = "Debug: Stop",
      })

      vim.keymap.set("n", "<leader>dr", debugger.run, {
        desc = "Debug: Run",
      })

      vim.keymap.set("n", "<leader>dv", debugger.show_variables, {
        desc = "Debug: Show Variables",
      })

      vim.keymap.set("n", "<leader>dt", debugger.show_backtrace, {
        desc = "Debug: Show Backtrace",
      })

      vim.keymap.set("n", "<leader>du", ":SwiftDebugUI<CR>", {
        desc = "Debug: Toggle UI",
      })

      -- ─────────────────────────────────────────────────────────────────────────
      -- 🔨 BUILD KEYBINDINGS
      -- ─────────────────────────────────────────────────────────────────────────

      vim.keymap.set("n", "<leader>bb", ":SwiftBuild<CR>", {
        desc = "Swift: Build",
      })

      vim.keymap.set("n", "<leader>br", ":SwiftRun<CR>", {
        desc = "Swift: Run",
      })

      vim.keymap.set("n", "<leader>bt", ":SwiftTest<CR>", {
        desc = "Swift: Test",
      })

      vim.keymap.set("n", "<leader>bc", ":SwiftClean<CR>", {
        desc = "Swift: Clean",
      })

      -- ─────────────────────────────────────────────────────────────────────────
      -- 💅 FORMATTER KEYBINDINGS
      -- ─────────────────────────────────────────────────────────────────────────

      vim.keymap.set("n", "<leader>sf", ":SwiftFormat<CR>", {
        desc = "Swift: Format File",
      })

      vim.keymap.set("v", "<leader>sf", ":SwiftFormatSelection<CR>", {
        desc = "Swift: Format Selection",
      })

      -- ─────────────────────────────────────────────────────────────────────────
      -- 🔍 LINTER KEYBINDINGS
      -- ─────────────────────────────────────────────────────────────────────────

      vim.keymap.set("n", "<leader>sl", ":SwiftLint<CR>", {
        desc = "Swift: Lint",
      })

      vim.keymap.set("n", "<leader>sL", ":SwiftLintFix<CR>", {
        desc = "Swift: Lint and Fix",
      })

      -- ─────────────────────────────────────────────────────────────────────────
      -- 🎯 TARGET KEYBINDINGS
      -- ─────────────────────────────────────────────────────────────────────────

      vim.keymap.set("n", "<leader>st", ":SwiftTarget<CR>", {
        desc = "Swift: Select Target",
      })

      vim.keymap.set("n", "<leader>sT", ":SwiftTargetList<CR>", {
        desc = "Swift: List Targets",
      })

      -- ─────────────────────────────────────────────────────────────────────────
      -- 📋 SNIPPETS KEYBINDINGS
      -- ─────────────────────────────────────────────────────────────────────────

      vim.keymap.set("n", "<leader>ss", ":SwiftSnippets<CR>", {
        desc = "Swift: List Snippets",
      })

      -- ─────────────────────────────────────────────────────────────────────────
      -- 🍎 XCODE KEYBINDINGS (solo macOS)
      -- ─────────────────────────────────────────────────────────────────────────

      if vim.fn.has("mac") == 1 then
        vim.keymap.set("n", "<leader>xb", ":SwiftXcodeBuild<CR>", {
          desc = "Xcode: Build",
        })

        vim.keymap.set("n", "<leader>xs", ":SwiftXcodeSchemes<CR>", {
          desc = "Xcode: Select Scheme",
        })

        vim.keymap.set("n", "<leader>xo", ":SwiftXcodeOpen<CR>", {
          desc = "Xcode: Open in Xcode.app",
        })
      end

      -- ─────────────────────────────────────────────────────────────────────────
      -- ℹ️  INFO & UTILS KEYBINDINGS
      -- ─────────────────────────────────────────────────────────────────────────

      vim.keymap.set("n", "<leader>si", ":SwiftInfo<CR>", {
        desc = "Swift: Plugin Info",
      })

      vim.keymap.set("n", "<leader>sv", ":SwiftVersionInfo<CR>", {
        desc = "Swift: Version Info",
      })

      vim.keymap.set("n", "<leader>sh", ":checkhealth swift<CR>", {
        desc = "Swift: Health Check",
      })

      -- ╔════════════════════════════════════════════════════════════════════════╗
      -- ║                           AUTOCOMMANDS                                 ║
      -- ╚════════════════════════════════════════════════════════════════════════╝

      local augroup = vim.api.nvim_create_augroup("SwiftNvimCustom", { clear = true })

      -- ─────────────────────────────────────────────────────────────────────────
      -- AUTO-FORMAT AL GUARDAR (descomenta para activar)
      -- ─────────────────────────────────────────────────────────────────────────

      -- vim.api.nvim_create_autocmd("BufWritePre", {
      --   group = augroup,
      --   pattern = "*.swift",
      --   callback = function()
      --     vim.cmd("SwiftFormat")
      --   end,
      --   desc = "Auto-format Swift files on save",
      -- })

      -- ─────────────────────────────────────────────────────────────────────────
      -- AUTO-LINT AL GUARDAR (ya está por defecto si auto_lint = true)
      -- ─────────────────────────────────────────────────────────────────────────

      -- ─────────────────────────────────────────────────────────────────────────
      -- HIGHLIGHT PARA DEBUG SIGNS (opcional, para personalizar colores)
      -- ─────────────────────────────────────────────────────────────────────────

      -- vim.api.nvim_set_hl(0, "SwiftBreakpoint", { fg = "#e06c75", bold = true })
      -- vim.api.nvim_set_hl(0, "SwiftCurrentLine", { fg = "#61afef", bold = true })

      -- ╔════════════════════════════════════════════════════════════════════════╗
      -- ║                      INTEGRACIÓN CON STATUSLINE                        ║
      -- ╚════════════════════════════════════════════════════════════════════════╝

      -- Si usas lualine, puedes agregar el target actual:
      -- require('lualine').setup({
      --   sections = {
      --     lualine_x = {
      --       function()
      --         local ok, target_manager = pcall(require, "swift.features.target_manager")
      --         if ok then
      --           local target = target_manager.get_current_target()
      --           if target then
      --             return "🎯 " .. target
      --           end
      --         end
      --         return ""
      --       end,
      --     },
      --   },
      -- })
    end,
  },

  -- ═══════════════════════════════════════════════════════════════════════════
  -- PLUGINS OPCIONALES PERO RECOMENDADOS
  -- ═══════════════════════════════════════════════════════════════════════════

  -- Nota: nvim-lspconfig ya NO se usa. sourcekit-lsp se configura de forma nativa
  -- con vim.lsp.enable('sourcekit') en lua/config/lsp.lua (Neovim >= 0.11).

  -- Autocompletion
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "saadparwaiz1/cmp_luasnip", -- Para snippets
    },
    -- config = function()
    --   local cmp = require("cmp")
    --   cmp.setup({
    --     snippet = {
    --       expand = function(args)
    --         require("luasnip").lsp_expand(args.body)
    --       end,
    --     },
    --     sources = {
    --       { name = "nvim_lsp" },
    --       { name = "luasnip" },
    --       { name = "buffer" },
    --       { name = "path" },
    --     },
    --   })
    -- end,
  },

  -- Snippet Engine (requerido para snippets de Swift)
  {
    "L3MON4D3/LuaSnip",
    -- swift.nvim incluye 50+ snippets de Swift automáticamente
  },

  -- Statusline (opcional, para mostrar target actual)
  {
    "nvim-lualine/lualine.nvim",
    -- opts = {
    --   sections = {
    --     lualine_x = {
    --       function()
    --         local ok, tm = pcall(require, "swift.features.target_manager")
    --         if ok then
    --           local target = tm.get_current_target()
    --           return target and ("🎯 " .. target) or ""
    --         end
    --         return ""
    --       end,
    --     },
    --   },
    -- },
  },
}
