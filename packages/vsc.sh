#!/usr/bin/env bash

# Install VSCode
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | \
    gpg --dearmor > packages.microsoft.gpg
sudo install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg
echo \
    "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/packages.microsoft.gpg] \
    https://packages.microsoft.com/repos/code stable main" | \
    sudo tee /etc/apt/sources.list.d/vscode.list > /dev/null
rm -f packages.microsoft.gpg
sudo apt-get update 
sudo apt-get install code -y -q

# Install VSCode extensions
function install_ext {
    print b "Installing extension: $1..."
    code --install-extension $1 --force > /dev/null 2>&1
}

declare -a vsc_ext=(
    eamodio.gitlens
    esbenp.prettier-vscode
    ms-azuretools.vscode-docker
    ms-vscode-remote.vscode-remote-extensionpack
    ms-vsliveshare.vsliveshare
    PKief.material-icon-theme
    redhat.vscode-yaml
    sdras.night-owl
    yzhang.markdown-all-in-one
)

for ext in "${vsc_ext[@]}"; do
    install_ext $ext
done

# Set themes
VSCONFIG_PATH=$HOME/.config/Code/User/settings.json
jq '."workbench.iconTheme" |= "material-icon-theme" | ."workbench.colorTheme" |= "Night Owl" | ."terminal.integrated.defaultProfile.linux" |= "zsh"' $VSCONFIG_PATH > tmp.json && \
    mv tmp.json $VSCONFIG_PATH || \
    exit 1
