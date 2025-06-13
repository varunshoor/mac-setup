#!/bin/bash

source utils.sh

# Install Homebrew Formulae
install_formula() {
  package=$1
  if test ! $(brew list | grep -w "$package"); then
    echo "Installing $package..."
    brew install "$package"
  else
    echo "$package already installed"
  fi
}

# Install Homebrew Casks
install_cask() {
  cask=$1
  if test ! $(brew list --cask | grep -i "$cask"); then
    echo "Installing $cask..."
    brew install --cask "$cask"
  else
    echo "$cask already installed"
  fi
}

# ------------------------------------------------------------------------------
e_message "Installing Homebrew Formulae"
# ------------------------------------------------------------------------------

# Core
install_formula "gcc"       # gnu compiler
install_formula "coreutils" # core gnu utils
install_formula "git"       # version control
install_formula "xz"
install_formula "zlib"
install_formula "openssh" # ssh
install_formula "zsh"     # shell
install_formula "curl"
install_formula "tmux"
install_formula "readline"
install_formula "fzf"
install_formula "certbot" # ssl cert cli
install_formula "openjdk" # java
install_formula "sqlite3"
install_formula "ffmpeg"      # media cli
install_formula "imagemagick" # image cli

# Mac
install_formula "mas"                        # app store cli
install_formula "stats"                      # stats
install_formula "jwbargsten/misc/defbro"     # browser cli
install_formula "koekeishiya/formulae/yabai" # window manager
install_formula "koekeishiya/formulae/skhd"  # utility for yabai

# Git
install_formula "gh"        # github cli
install_formula "lazygit"   # git cli
install_formula "tig"       # git cli
install_formula "git-delta" # git diff

# System
install_formula "btop"   # resource monitor
install_formula "atuin"  # improved shell history
install_formula "direnv" # env switcher

# Fonts
install_formula "fontforge" # font editor

# AI
install_formula "ollama" # gen ai

# Utilities
install_formula "fd"            # find cli
install_formula "dockutil"      # dock cli
install_formula "bat"           # cat cli
install_formula "speedtest-cli" # speedtest cli
install_formula "cheat"         # cheat sheet cli
install_formula "dust"          # du cli
install_formula "eza"           # improved ls
install_formula "htop"          # top cli
install_formula "procs"         # ps cli
install_formula "ncdu"          # du cli
install_formula "sad"           # search and replace cli
install_formula "ripgrep"       # grep cli
install_formula "tree"          # tree cli
install_formula "nnn"           # file manager
install_formula "prettyping"    # ping cli
install_formula "yazi"          # improved file manager
install_formula "watchman"      # file watcher
install_formula "watchexec"     # file watcher (better)
install_formula "wget"          # file download cli
install_formula "tealdeer"      # tldr cli

# Shell & Terminal
install_formula "tmuxinator" # tmux cli
install_formula "zoxide"     # cd cli
install_formula "zplug"      # zsh plugin manager
install_formula "oh-my-posh" # posh theme

# Audio & Video
install_formula "handbrake" # video transcoder

# DB
install_formula "atlas"                   # db toolkit
install_formula "harlequin"               # db cli
install_formula "tursodatabase/tap/turso" # sqlite db

# Docker
install_formula "lazydocker" # docker cli
install formula "ctop"       # container metrics
install_formula "dive"       # docker image layer analysis

# DNS
install_formula "doggo" # dns cli

# Kubernetes
install_formula "k9s"                  # k8s cli
install_formula "kdash-rs/kdash/kdash" # k8s dashboard
install_formula "kubectx"              # k8s ctx switcher
install_formula "minikube"             # k8s cli
install_formula "eksctl"               # eks cli

# Cloud
install_formula "doctl" # digital ocean cli

# JS & TS
install_formula "fnm"  # node version manager
install_formula "pnpm" # node package manager

# Golang
install_formula "go"            # go lang
install_formula "golangci-lint" # go linter

# JSON
install_formula "gron" # json cli
install_formula "jq"   # json cli

# Lua
install_formula "luarocks" # lua package manager

# Python
# See: https://github.com/nicolashery/mac-dev-setup
# See: https://github.com/sb2nov/mac-setup/tree/main/Python
install_formula "pyenv"            # python env
install_formula "pyenv-virtualenv" # python virtual env
install_formula "pipx"             # python cli

# Markdown
install_formula "glow" # markdown reader

# HTTP & API
install_formula "httpie" # http cli
install_formula "plow"   # http benchmarking

# Rust
install_formula "rust" # rust lang

# PHP
install_formula "php" # php lang

# IaC
install_formula "pulumi" # infra as code

# CSV & Data
install_formula "visidata"    # csv cli
install_formula "tidy-viewer" # csv cli
install_formula "octosql"     # sql cli

# YAML
install_formula "yq" # yaml cli

# Image
install_formula "silicon" # image cli

# Vim
install_formula "neovim" # vim cli

# AI
install_formula "sst/tap/opencode" # Open Code. See: https://github.com/sst/opencode/tree/dev

# Proxy Servers
install_formula "peterldowns/tap/localias" # Local Dev Secure Aliases

# ------------------------------------------------------------------------------
e_message "Installing Homebrew Casks"
# ------------------------------------------------------------------------------

install_cask "raycast"                       # productivity app
install_cask "slack"                         # chat app
install_cask "spotify"                       # music app
install_cask "zoom"                          # video conferencing
install_cask "google-chrome"                 # web browser
install_cask "google-drive"                  # cloud storage
install_cask "discord"                       # chat app
install_cask "gpg-suite"                     # gpg keychain
install_cask "figma"                         # design app
install_cask "1password"                     # password manager
install_cask "1password-cli"                 # password manager cli
install_cask "ghostty"                       # terminal app
install_cask "kitty"                         # terminal app
install_cask "rectangle-pro"                 # window manager
install_cask "arduino-ide"                   # arduino ide
install_cask "min"                           # minimal browser
install_cask "firefox"                       # web browser
install_cask "whatsapp"                      # chat app
install_cask "telegram"                      # chat app
install_cask "signal"                        # chat app
install_cask "docker"                        # containerization
install_cask "dropbox"                       # cloud storage
install_cask "bartender"                     # menu bar manager
install_cask "notion"                        # productivity app
install_cask "notion-calendar"               # calendar app
install_cask "superhuman"                    # email app
install_cask "backblaze"                     # backup app
install_cask "chatgpt"                       # chat app
install_cask "claude"                        # chat app
install_cask "keka"                          # file archiver
install_cask "vlc"                           # media player
install_cask "flux"                          # screen color
install_cask "hazel"                         # file organizer
install_cask "pdf-expert"                    # pdf editor
install_cask "monodraw"                      # ascii art
install_cask "cleanshot"                     # screen capture
install_cask "cloudflare-warp"               # vpn
install_cask "ogdesign-eagle"                # image organizer
install_cask "contexts"                      # window manager
install_cask "devtoys"                       # dev tools
install_cask "elgato-stream-deck"            # stream deck
install_cask "google-chrome@dev"             # chrome for dev
install_cask "hammerspoon"                   # macos automation
install_cask "loom"                          # video recording
install_cask "little-snitch"                 # network monitor
install_cask "obs"                           # streaming app
install_cask "outline-manager"               # vpn
install_cask "visual-studio-code"            # code editor
install_cask "tableplus"                     # database manager
install_cask "microsoft-office"              # office suite
install_cask "logi-options+"                 # mouse manager
install_cask "homerow"                       # keyboard manager
install_cask "opal-composer"                 # camera app
install_cask "font-jetbrains-mono-nerd-font" # font
install_cask "mac-mouse-fix"                 # mouse manager
install_cask "bruno"                         # api testing

# ------------------------------------------------------------------------------
e_message "Homebrew Casks and Formulae complete"
# ------------------------------------------------------------------------------
