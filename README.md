# dotfiles

Personal configuration for my development environment, managed with
[GNU Stow](https://www.gnu.org/software/stow/). Each top-level folder is a Stow "package"
that mirrors the real path relative to `$HOME`.

## Structure

```
dotfiles/
  nvim/.config/nvim/...           Neovim config (lazy.nvim + Lua)
  tmux/.config/tmux/tmux.conf     tmux config
  zsh/.zshrc                      zsh / Oh My Zsh config (secrets excluded)
  ghostty/.config/ghostty/...     Ghostty terminal config
  git/.gitconfig                  Global git config
  opencode/.config/opencode/...   opencode config
```

## Install

```sh
brew install stow
cd ~/dotfiles
stow nvim tmux zsh ghostty git opencode
```

This creates symlinks such as `~/.config/nvim -> ~/dotfiles/nvim/.config/nvim`,
`~/.zshrc -> ~/dotfiles/zsh/.zshrc`, etc. To remove a package's symlinks: `stow -D <package>`.
To re-link after adding new files to a package: `stow <package>` again.

## Secrets

`zsh/.zshrc` does **not** contain any API keys/tokens. Instead it sources an untracked file,
`~/.zshrc.secrets`, if present:

```sh
[ -f "$HOME/.zshrc.secrets" ] && source "$HOME/.zshrc.secrets"
```

On a new machine, create `~/.zshrc.secrets` (outside this repo, never committed) with your own
export lines, e.g.:

```sh
export FIGHTCAMP_GITHUB_TOKEN=...
export OPENAI_API_KEY=...
export GEMINI_API_KEY=...
export SEGMENT_TOKEN=...
```

## Tools

### Neovim (`nvim/`)

Full plugin list, keymaps, and LSP setup are documented in
[`nvim/.config/nvim/README.md`](nvim/.config/nvim/README.md) — it covers lazy.nvim plugins
(telescope, harpoon, neo-tree, which-key, DAP, swift.nvim, git tooling, vim-tmux-navigator,
etc.) and every keymap in detail.

### tmux (`tmux/`)

Config lives at `tmux/.config/tmux/tmux.conf` (tmux's native XDG config path — no `~/.tmux.conf`
needed). Highlights:

| Keymap | Action |
|---|---|
| `prefix` | `C-s` |
| `prefix + h/j/k/l` | Move focus between panes |
| `prefix + \|` / `prefix + _` | Split vertical / horizontal |
| `prefix + g` | Toggle [lazygit](https://github.com/jesseduffield/lazygit) in a floating popup (90%×90%, auto-closes on exit) |
| `prefix + r` | Reload tmux config |
| `prefix + S` / `prefix + R` | Save / restore session (tmux-resurrect) |

Plugins (via TPM): `catppuccin/tmux`, `tmux-cpu`, `tmux-battery`, `tmux-resurrect`,
`tmux-continuum` (auto session restore), `vim-tmux-navigator` (paired with the Neovim plugin of
the same name for seamless `<C-h/j/k/l>` navigation between Neovim splits and tmux panes).

### zsh (`zsh/`)

Oh My Zsh + Powerlevel10k, `starship` and `zoxide` init, vim-mode keybindings
(`bindkey -v`) with a block/beam cursor indicator for normal/insert mode. Notable aliases:

| Alias | Action |
|---|---|
| `nv` | `nvim` |
| `cdroot` | `cd` to the current git repo's top-level directory |

### Ghostty (`ghostty/`)

Terminal config: Catppuccin Mocha theme, JetBrainsMono Nerd Font, clipboard read/write allowed,
copy-on-select enabled.

### git (`git/`)

Global `.gitconfig`: Kaleidoscope as diff/merge tool, Git LFS filters enabled.

### opencode (`opencode/`)

`opencode.jsonc`: default model `anthropic/opus-4-6`, asks before edits, allows bash freely, and
defines a `code-reviewer` subagent focused on security/readability/performance/maintainability.
