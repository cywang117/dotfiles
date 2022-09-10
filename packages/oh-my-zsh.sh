#!/usr/bin/env bash

rm -rf /home/christina/.oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

# Install pure prompt https://github.com/sindresorhus/pure
mkdir -p "$HOME/.zsh"
[[ -d "$HOME/.zsh/pure" ]] && rm -rf "$HOME/.zsh/pure"
git clone https://github.com/sindresorhus/pure.git "$HOME/.zsh/pure"

# Remove old .zshrc
rm "$HOME/.zshrc.pre-oh-my-zsh*"
