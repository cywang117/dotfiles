#!/usr/bin/env bash

TARBALL_URL=$(curl -s https://api.github.com/repos/dylanaraps/neofetch/releases/latest | jq -r '.tarball_url')
curl -sL "$TARBALL_URL" > neofetch.tar.gz
tar -xzf neofetch.tar.gz && rm neofetch.tar.gz
NEOFETCH_DIR=$(basename $(find -maxdepth 1 -type d -name "*neofetch*"))
mkdir -p ~/.neofetch && mv $NEOFETCH_DIR/* ~/.neofetch
rm -rf $NEOFETCH_DIR
cd ~/.neofetch
sudo make install
