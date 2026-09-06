#!/usr/bin/env bash
set -Eeuo pipefail
CONFIG_DIR="$HOME/.config/linux-admin-dotfiles"
BASHRC="$HOME/.bashrc"
BEGIN='# >>> linux-admin-dotfiles >>>'
END='# <<< linux-admin-dotfiles <<<'
if [[ -f "$BASHRC" ]]; then
  awk -v b="$BEGIN" -v e="$END" '$0==b{skip=1;next}$0==e{skip=0;next}!skip{print}' "$BASHRC" > "$BASHRC.tmp"
  mv "$BASHRC.tmp" "$BASHRC"
fi
if [[ -f "$CONFIG_DIR/latest-backup" ]]; then
  BACKUP_DIR=$(cat "$CONFIG_DIR/latest-backup")
  [[ -f "$BACKUP_DIR/.vimrc" ]] && cp -a "$BACKUP_DIR/.vimrc" "$HOME/.vimrc"
  [[ -f "$BACKUP_DIR/.bash_aliases" ]] && cp -a "$BACKUP_DIR/.bash_aliases" "$HOME/.bash_aliases"
fi
rm -rf "$CONFIG_DIR"
echo 'Configuration removed. Run: source ~/.bashrc'
