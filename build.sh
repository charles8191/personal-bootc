#!/bin/bash

set -ouex pipefail

test -f /usr/lib64/libscudo.so && \
chmod +x /usr/lib64/libscudo.so && \
echo /usr/lib64/libscudo.so > /etc/ld.so.preload

dnf install gnome-disk-utility gnome-tweaks gnome-system-monitor chromium -y

mkdir -p /etc/flatpak/remotes.d
curl -o /etc/flatpak/remotes.d/flathub.flatpakrepo https://dl.flathub.org/repo/flathub.flatpakrepo