# Neovim Config

Personal Neovim configuration using [lazy.nvim](https://github.com/folke/lazy.nvim) as the
plugin manager. Leader key is `<Space>`.

## Structure

```
init.lua                 -- entry point, requires everything below
lua/config/
  options.lua             -- vim.opt settings
  globals.lua             -- leader key, global flags
  lazy.lua                -- bootstraps lazy.nvim
  lsp.lua                 -- native vim.lsp.enable() setup + diagnostics config
  colorscheme.lua         -- active colorscheme
  keymap.lua              -- general (non-plugin) keymaps
lua/plugins/*.lua         -- one file per plugin (or plugin group), lazy.nvim spec
lsp/*.lua                 -- per-server LSP configs (lua_ls, clangd, sourcekit)
```

## Plugins

| Plugin | Purpose |
|---|---|
| [lazy.nvim](https://github.com/folke/lazy.nvim) | Plugin manager |
| [kanagawa.nvim](https://github.com/rebelot/kanagawa.nvim) | Active colorscheme |
| [catppuccin](https://github.com/catppuccin/nvim) | Alternate colorscheme (disabled) |
| [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim) | Fuzzy finder (files, grep, buffers, help) |
| [neo-tree.nvim](https://github.com/nvim-neo-tree/neo-tree.nvim) | File explorer sidebar |
| [harpoon](https://github.com/ThePrimeagen/harpoon) (harpoon2 branch) | Pin and instantly jump between frequently used files |
| [which-key.nvim](https://github.com/folke/which-key.nvim) | On-demand popup showing available keymaps (manual trigger only, no auto-popup) |
| [blink.cmp](https://github.com/saghen/blink.cmp) | Completion engine |
| [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter) | Syntax highlighting / indent via treesitter |
| [lualine.nvim](https://github.com/nvim-lualine/lualine.nvim) | Statusline |
| [render-markdown.nvim](https://github.com/MeanderingProgrammer/render-markdown.nvim) | Rendered markdown preview in-buffer |
| [git-conflict.nvim](https://github.com/akinsho/git-conflict.nvim) | Merge conflict highlighting/navigation |
| [diffview.nvim](https://github.com/sindrets/diffview.nvim) | Git diff / merge tool views |
| [gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim) | Git gutter signs, hunk preview, blame |
| [nvim-dap](https://github.com/mfussenegger/nvim-dap) + [nvim-dap-ui](https://github.com/rcarriga/nvim-dap-ui) + [mason-nvim-dap.nvim](https://github.com/jay-babu/mason-nvim-dap.nvim) | Debug Adapter Protocol client/UI (C/C++ via codelldb) |
| [mason.nvim](https://github.com/williamboman/mason.nvim) | LSP/DAP tool installer |
| [swift.nvim](https://github.com/devswiftzone/swift.nvim) | Swift tooling: build/run/test, linter, formatter, debugger, Xcode integration (loads only for `.swift` files) |
| [nvim-cmp](https://github.com/hrsh7th/nvim-cmp), [LuaSnip](https://github.com/L3MON4D3/LuaSnip) | Completion/snippets dependencies for swift.nvim |
| [alpha-nvim](https://github.com/goolord/alpha-nvim) | Start screen (disabled) |
| [noice.nvim](https://github.com/folke/noice.nvim) | UI for messages/cmdline/popupmenu (disabled) |
| [mini.icons](https://github.com/echasnovski/mini.icons) | Icon provider used by which-key |
| [vim-tmux-navigator](https://github.com/christoomey/vim-tmux-navigator) | Seamless `<C-h/j/k/l>` navigation between Neovim splits and tmux panes |

### LSP servers (native `vim.lsp.enable`)

- `lua_ls` — Lua
- `clangd` — C/C++ (with `--background-index`, `--clang-tidy`, compile-commands in `build/`)
- `sourcekit` — Swift (configured natively; swift.nvim's own LSP feature is disabled to avoid
  double setup, see `lua/plugins/swift.lua` and `lua/config/lsp.lua`)

## Keymaps

Leader is `<Space>`.

### General

| Keymap | Mode | Action |
|---|---|---|
| `j` / `k` / `<Down>` / `<Up>` | n, x, i | Move by visual line (`gj`/`gk`) instead of logical line |
| `<A-j>` / `<A-k>` | n | Move current line down / up |
| `<A-j>` / `<A-k>` | v | Move selected block down / up |
| `<leader>y` | n, x | Copy to system clipboard |
| `<leader>p` / `<leader>P` | n, x | Paste from system clipboard after / before cursor |
| `<leader>bb` | n | Switch to alternate buffer |
| `<leader>bn` / `<leader>bp` | n | Next / previous buffer |
| `<leader>/` | n | Toggle search highlighting (and redraw) |
| `<leader>l` | n | Toggle visible whitespace (`listchars`) |
| `\|` / `_` | n | Vertical / horizontal split |
| `<C-h>` `<C-j>` `<C-k>` `<C-l>` | n, t | Move focus left / down / up / right — seamlessly crosses into tmux panes too (vim-tmux-navigator) |
| `<Esc>` | n | Clear search highlight |
| `<C-Up>` `<C-Down>` `<C-Left>` `<C-Right>` | n | Resize current split |
| `jj` | i | Exit insert mode |
| `=` | n | Format current file (LSP) |
| `<leader>rn` | n | LSP rename |
| `<leader>ca` | n | LSP code action |
| `<leader>sh` | n | Switch header/source (clangd only) |

### DAP (debugger, `nvim-dap`)

| Keymap | Action |
|---|---|
| `<leader>dc` | Continue |
| `<leader>dn` | Step over |
| `<leader>di` | Step into |
| `<leader>do` | Step out |
| `<leader>db` | Toggle breakpoint |
| `<leader>dt` | Terminate |
| `<leader>du` | Toggle DAP UI |

### Telescope

| Keymap | Action |
|---|---|
| `<leader>ff` | Find files |
| `<leader>fg` | Live grep |
| `<leader>fb` | List buffers |
| `<leader>fh` | Help tags |

### Neo-tree

| Keymap | Action |
|---|---|
| `<leader>E` | Toggle Neo-tree sidebar |
| `<leader>e` | Focus Neo-tree on current file |

Inside Neo-tree window: `l` open, `Z` expand all nodes, `z` close all nodes.

### Harpoon

| Keymap | Action |
|---|---|
| `<leader>a` | Add current file to harpoon list |
| `<leader>h` | Toggle harpoon quick-menu |
| `<leader>1` `<leader>2` `<leader>3` `<leader>4` | Jump to harpoon slot 1–4 |
| `<C-S-P>` / `<C-S-N>` | Jump to previous / next harpoon file |

Inside the quick-menu buffer: `<CR>` selects the file under cursor, `q`/`<Esc>` closes,
delete/reorder lines like a normal buffer to remove/reorder entries (auto-saved on leave).

### Which-key

| Keymap | Action |
|---|---|
| `<leader>?` | Show buffer-local keymaps popup (manual only — no auto popup while typing) |

### Git

| Keymap | Action |
|---|---|
| `<leader>jo` | Open Diffview |
| `<leader>jc` | Close Diffview |
| `<leader>jp` | Gitsigns preview hunk |
| `<leader>jt` | Gitsigns toggle current line blame |

`git-conflict.nvim` uses its own default mappings for navigating/resolving merge conflicts.

### Swift (`.swift` files only, via swift.nvim)

> Note: swift.nvim sets these globally once a `.swift` buffer triggers the plugin to load, which
> means `<leader>sh` and the `<leader>d*` bindings below will shadow the general `<leader>sh`
> (switch header/source) and DAP `<leader>d*` keymaps for the rest of the session.

| Keymap | Action |
|---|---|
| `<F5>` | Debug: continue/run |
| `<F9>` | Debug: toggle breakpoint |
| `<F10>` / `<F11>` / `<F12>` | Debug: step over / into / out |
| `<leader>db` / `<leader>dB` | Toggle breakpoint / clear all breakpoints |
| `<leader>dc` / `<leader>ds` / `<leader>dr` | Continue / stop / run |
| `<leader>dv` / `<leader>dt` | Show variables / backtrace |
| `<leader>du` | Toggle debug UI |
| `<leader>bb` / `<leader>br` / `<leader>bt` / `<leader>bc` | Build / run / test / clean |
| `<leader>sf` (n), `<leader>sf` (v) | Format file / format selection |
| `<leader>sl` / `<leader>sL` | Lint / lint and fix |
| `<leader>st` / `<leader>sT` | Select target / list targets |
| `<leader>ss` | List snippets |
| `<leader>xb` / `<leader>xs` / `<leader>xo` | Xcode: build / select scheme / open in Xcode.app (macOS only) |
| `<leader>si` / `<leader>sv` | Plugin info / version info |
| `<leader>sh` | Health check |

### LSP (sourcekit / Swift buffers, on attach)

| Keymap | Action |
|---|---|
| `gd` | Go to definition |
| `K` | Hover |
| `gi` | Go to implementation |
| `gr` | Find references |
| `<leader>rn` | Rename |
| `<leader>ca` | Code action |

## Tmux integration

This config pairs with `~/.tmux.conf` (outside this repo) for a smoother workflow:

- **`vim-tmux-navigator`** (see Plugins above) lets `<C-h>` / `<C-j>` / `<C-k>` / `<C-l>` move
  focus seamlessly between Neovim splits and tmux panes — no need to think about which one
  you're in.
- **`prefix+g`** opens [lazygit](https://github.com/jesseduffield/lazygit) in a floating tmux
  popup (90% width/height) via `display-popup`. The popup closes automatically when you quit
  lazygit (`q`), so it acts as a quick toggle without needing a dedicated pane.
- Tmux pane navigation is also bound directly to `prefix+h/j/k/l` (`select-pane`), independent of
  the Neovim-aware navigator above.
