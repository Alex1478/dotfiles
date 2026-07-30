#!/usr/bin/env bash
# Bootstrap script for setting up this dotfiles repo on a new machine.
# Safe to re-run; existing real files are backed up (not deleted) before stowing.
# Written to be compatible with the ancient bash 3.2 macOS ships by default
# (no associative arrays, no process substitution).
set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PACKAGES="nvim tmux zsh ghostty git opencode"
BACKUP_DIR="$HOME/.dotfiles-backup-$(date +%Y%m%d%H%M%S)"

echo "==> Dotfiles directory: $DOTFILES_DIR"

# 1. Homebrew
if ! command -v brew >/dev/null 2>&1; then
  echo "==> Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# 2. Core tools
echo "==> Installing core tools via Homebrew (stow, git, neovim, tmux, lazygit, starship, zoxide, ripgrep, fd)..."
brew install stow git neovim tmux lazygit starship zoxide ripgrep fd 2>&1 | tail -5

# 3. Back up any conflicting real files/dirs before stowing
target_for_package() {
  case "$1" in
    nvim) echo "$HOME/.config/nvim" ;;
    tmux) echo "$HOME/.config/tmux" ;;
    zsh) echo "$HOME/.zshrc" ;;
    ghostty) echo "$HOME/.config/ghostty" ;;
    git) echo "$HOME/.gitconfig" ;;
    opencode) echo "$HOME/.config/opencode" ;;
  esac
}

backed_up_any=false
for pkg in $PACKAGES; do
  target="$(target_for_package "$pkg")"
  if [ -L "$target" ]; then
    echo "==> $target is already a symlink, removing before re-stow"
    rm "$target"
  elif [ -e "$target" ]; then
    echo "==> Backing up existing $target -> $BACKUP_DIR/"
    mkdir -p "$BACKUP_DIR"
    mv "$target" "$BACKUP_DIR/$(basename "$target")"
    backed_up_any=true
  fi
done
if [ "$backed_up_any" = true ]; then
  echo "==> Backed up pre-existing configs to $BACKUP_DIR"
fi

# 4. Stow everything
echo "==> Stowing packages: $PACKAGES"
cd "$DOTFILES_DIR"
stow -v $PACKAGES

# 5. Secrets file (never tracked by git)
if [ ! -f "$HOME/.zshrc.secrets" ]; then
  echo "==> Creating empty ~/.zshrc.secrets (add your real tokens here manually)"
  cat > "$HOME/.zshrc.secrets" <<'EOF'
# Add your real secrets here. This file is NOT tracked by git.
# export FIGHTCAMP_GITHUB_TOKEN=...
# export OPENAI_API_KEY=...
# export GEMINI_API_KEY=...
# export SEGMENT_TOKEN=...
EOF
  chmod 600 "$HOME/.zshrc.secrets"
fi

# 6. tmux plugin manager (TPM)
if [ ! -d "$HOME/.tmux/plugins/tpm" ]; then
  echo "==> Cloning tmux plugin manager (TPM)"
  git clone https://github.com/tmux-plugins/tpm "$HOME/.tmux/plugins/tpm"
  echo "    Open tmux and press 'prefix + I' to install tmux plugins."
fi

echo ""
echo "==> Done. Next steps:"
echo "    1. exec zsh                 # reload shell with the new .zshrc"
echo "    2. Edit ~/.zshrc.secrets with your real tokens"
echo "    3. nvim                     # bootstraps lazy.nvim and installs plugins on first launch"
echo "    4. tmux, then prefix + I    # installs tmux plugins via TPM"
