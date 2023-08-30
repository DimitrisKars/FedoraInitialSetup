#!/bin/bash

# Make sure only root can run the script
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root"
   exit 1
fi

cd ..

# Remove games
dnf remove -y gnome-games*
dnf remove -y aisleriot

# Remove office programs
dnf remove -y libreoffice*

# Remove other non-essential programs (example)
dnf remove -y cheese rhythmbox
dnf remove -y firefox
dnf update -y

sudo dnf install dnf-plugins-core

sudo dnf config-manager --add-repo https://brave-browser-rpm-release.s3.brave.com/brave-browser.repo

sudo rpm --import https://brave-browser-rpm-release.s3.brave.com/brave-core.asc

sudo dnf install brave-browser brave-keyring

dnf install gnome-tweaks -y

dnf install gnome-shell-extension -y

dnf install curl -y

curl https://github.com/catppuccin/gtk/releases/download/v0.6.1/Catppuccin-Frappe-Standard-Yellow-dark.zip

curl https://befonts.com/downfile/a026d81d538d66279c15808f56779fcb.43523

unzip a026d81d538d66279c15808f56779fcb.43523

mkdir -p ~/.fonts

sudo mv *.ttf /usr/share/fonts/
# or if they are .otf files
# sudo mv *.otf /usr/share/fonts/
sudo fc-cache -f -v

## If migrating from prior bintray install instructions please first...
# sudo rm /etc/yum.repos.d/bintray-ookla-rhel.repo
# sudo yum remove speedtest
## Other non-official binaries will conflict with Speedtest CLI
# Example how to remove using yum
# rpm -qa | grep speedtest | xargs -I {} sudo yum -y remove {}
curl -s https://packagecloud.io/install/repositories/ookla/speedtest-cli/script.rpm.sh | sudo bash
dnf install speedtest
flatpak install flathub com.raggesilver.BlackBox

git clone https://github.com/AdnanHodzic/auto-cpufreq.git
cd auto-cpufreq && sudo ./auto-cpufreq-installer
sudo auto-cpufreq --install
systemctl status auto-cpufreq
echo q | command
cd ..

if command -v curl >/dev/null 2>&1; then
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/romkatv/zsh4humans/v5/install)"
else
  sh -c "$(wget -O- https://raw.githubusercontent.com/romkatv/zsh4humans/v5/install)"
fi
