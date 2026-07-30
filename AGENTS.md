# Agent Instructions

This repo (`dotfiles`) holds personal configuration for multiple tools, each in its own
top-level folder, managed with [GNU Stow](https://www.gnu.org/software/stow/):

- `nvim/` — Neovim config (lazy.nvim + Lua)
- `tmux/` — tmux config
- `zsh/` — zsh / Oh My Zsh config (secrets excluded, see below)
- `ghostty/` — Ghostty terminal config
- `git/` — global `.gitconfig`
- `opencode/` — opencode config

Each folder mirrors the real path relative to `$HOME` (e.g. `nvim/.config/nvim/...`), so
`stow <folder>` from the repo root creates the right symlinks.

## Keep README.md in sync

**Every time a keymap is added/changed/removed, a plugin is installed/removed, or any tracked
tool's configuration changes in a way a human would want to know about, update `README.md`
accordingly before finishing the task.**

Specifically:
- **Neovim** (`nvim/`): follow `nvim/.config/nvim/README.md`'s own conventions — update its
  Plugins table and Keymaps tables for any plugin/keymap change, including noting any
  keymap shadowing/conflicts introduced.
- **tmux** (`tmux/`): if a keybinding is added/changed/removed in `tmux.conf`, update the root
  `README.md`'s tmux section.
- **zsh** (`zsh/`): if aliases, exported env vars (non-secret), or plugins change, update the
  root `README.md`'s zsh section. Never commit real secrets — see below.
- **ghostty / git / opencode**: if their tracked config files change in a way that affects
  daily usage (new keybind, new option worth knowing about), reflect it in the root
  `README.md`.

Do this as part of the same change — don't leave it for a follow-up unless the user explicitly
asks to defer it.

## Secrets

`zsh/.zshrc` intentionally excludes API tokens/keys. It sources an untracked
`~/.zshrc.secrets` file (outside this repo) if present. **Never add real secrets to any file
tracked in this repo.** If you need to reference where a secret should be set, add a commented
placeholder or a note in `README.md`, not the actual value.
