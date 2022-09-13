#!/usr/bin/env bash

# Install
sudo apt install python3-pyinotify python3-systemd 2to3
cd /tmp
git clone https://github.com/fail2ban/fail2ban.git
cd fail2ban
$(which python) || sudo ./fail2ban-2to3
sudo python3 setup.py install --without tests

# Set up systemd service
sudo cp ./build/fail2ban.service /etc/systemd/system/fail2ban.service
sudo systemctl enable fail2ban
sudo groupadd fail2ban || true
sudo usermod -a -G fail2ban $USER
sudo chown root:fail2ban /var/run/fail2ban/fail2ban.sock
sudo chmod g+rwx /var/run/fail2ban/fail2ban.sock

SYSTEMD_EDITOR=tee sudo systemctl edit fail2ban <<EOF
[Service]
ExecStartPost=/bin/sh -c "while ! [ -S /run/fail2ban/fail2ban.sock ]; do sleep 1; done"
ExecStartPost=/bin/chgrp fail2ban /run/fail2ban/fail2ban.sock
ExecStartPost=/bin/chmod g+w /run/fail2ban/fail2ban.sock
EOF
