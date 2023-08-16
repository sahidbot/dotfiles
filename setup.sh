#!/usr/bin/env bash

################################################################################
# setup.sh
#
# This script uses GNU Stow to symlink files and directories into place.
# It can be run safely multiple times on the same machine. (idempotency)
################################################################################

print_log() {
  local fmt="$1"; shift

  # shellcheck disable=SC2059
  printf "${fmt}\\n" "$@"
}

osname=$(uname)
if [ "$osname" != "Darwin" ]; then
  dotfiles_print_log "Oops, it looks like you're using a non-Apple system. Sorry, this script only supports macOS. Exiting..."
  exit 1
fi

setup_config_dir() {
  if [ -z "$XDG_CONFIG_HOME" ]; then
    print_log "Setting up ~/.config directory..."
    if [ ! -d "${HOME}/.config" ]; then
      mkdir "${HOME}/.config"
    fi
    export XDG_CONFIG_HOME="${HOME}/.config"
  fi
}

check_homebrew_path() {
  print_log "Checking homebrew path..."
  arch="$(uname -m)"
  if [ "$arch" == "arm64" ]; then
    print_log "You're on Apple Silicon! Setting HOMEBREW_PREFIX to /opt/homebrew..."
    HOMEBREW_PREFIX="/opt/homebrew"
  else
    print_log "You're on an Intel Mac! Setting HOMEBREW_PREFIX to /usr/local..."
    HOMEBREW_PREFIX="/usr/local"
  fi
}

setup_nvim() {
  src="$(pwd)/nvim"
  dest="$HOME/.config/nvim"

  print_log "\\nSetting up $dest"
  if [ -L ${dest} ] || [ -e ${dest} ]; then
    print_log "Already exits $dest"
  else
    print_log "Created symlink from $src to $dest"
  fi
}

setup_tmux() {
  # .tmux.conf
  src="$(pwd)/tmux/tmux.conf"
  dest="$HOME/.tmux.conf"
  print_log "\\nSetting up $dest"
  if [ -L ${dest} ] || [ -e ${dest} ]; then
    print_log "Already exits $dest"
  else
    ln -s $src $dest
    print_log "Created symlink from $src to $dest"
  fi

  # .tmux/plugins/tpm
  dest="$HOME/.tmux/plugins/tpm"
  print_log "\\nSetting up $dest"
  if [ -e ${dest} ] || [ -L ${dest} ]; then
    print_log "Already exits $dest"
  else
    print_log "Cloning https://github.com/tmux-plugins/tpm into $dest"
    mkdir -p "$HOME/.tmux/plugins"
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
    echo "
    # Type this in terminal if tmux is already running
    tmux source ~/.tmux.conf

    # Open tmux to install all plugins and press
    prefix + I
    "
  fi
}

# sudo -v # gain root access
set -e # terminate script if anything exits with a non-zero value

print_log "Initializing dotfiles..."
setup_config_dir

setup_nvim
setup_tmux
