#!/usr/bin/env bash

LATEST_SEMVER=$(curl -s https://api.github.com/repos/balena-io/balena-cli/releases/latest | jq -r '.tag_name')
ZIP_FILE=balena.zip

curl -sL -o $ZIP_FILE "https://github.com/balena-io/balena-cli/releases/download/$LATEST_SEMVER/balena-cli-$LATEST_SEMVER-linux-x64-standalone.zip"
mkdir -p "$HOME/.local/bin"
unzip -o $ZIP_FILE -d "$HOME/.local/bin"
rm -f $ZIP_FILE
