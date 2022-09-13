#!/usr/bin/env bash

CWD=$(realpath $(dirname -- "$0"))
SERVER=false
DEV=false
USAGE="
Usage: $(basename $0) [OPTIONS]

With no options specified, will install basic packages only.

Options:
    -s  Install server packages
    -d  Install dev packages
"

while getopts "sd" arg; do
    case $arg in
        s)
            SERVER=true
            ;;
        d)
            DEV=true
            ;;
        *)
            echo "$USAGE"
            exit 0
            ;;
    esac
done

# Source utility scripts
for file in $CWD/utils/*; do
    source $file
done

# Update repositories & installed packages
print g "Updating repositories..."
sudo apt-get update
sudo apt-get upgrade -y

# All packages below prefer a local script for install if available in packages/*
# Basic packages
declare -a basic_packages=(
    curl
    wget
    gpg
    apt-transport-https
    ca-certificates
    lsb-release
    htop
    jq
    zsh
    tmux
    docker
    oh-my-zsh
    fonts-powerline
    tmux-conf
    antigen
)

# Dev only packages
declare -a dev_packages=(
    vsc
    nvm
    balena-cli
)

# Server only packages
declare -a server_packages=(
    net-tools
    openssh-server
    neofetch
    fail2ban
)

print g "Installing packages..."
install basic_packages

[[ "$SERVER" == "true" ]] && install server_packages
[[ "$DEV" == "true" ]] && install dev_packages

# Copy dotfiles
print g "Copying dotfiles..."
for dotfile in $CWD/.[^.]*; do
    [[ -f $dotfile ]] && cp $dotfile $HOME
done

# Copy local scripts
print g "Copying local scripts..."
mkdir -p ~/.local/bin || true
for script in $CWD/bin/*; do
    cp $script ~/.local/bin
done
