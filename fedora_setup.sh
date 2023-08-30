#!/bin/bash

# Make sure only root can run the script
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root"
   exit 1
fi

cd ..

if command -v curl >/dev/null 2>&1; then
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/romkatv/zsh4humans/v5/install)"
else
  sh -c "$(wget -O- https://raw.githubusercontent.com/romkatv/zsh4humans/v5/install)"
fi

# echo 2 | command
# echo 1 | command
# echo n | command
# echo n | command
# echo 1 | command
# echo y | command
# echo y | command
# # --------
# echo y | command
# echo n | command
# echo n | command
# # --------
# echo 3 | command
# echo 1 | command
# echo 2 | command
# echo 1 | command
# echo 1 | command
# echo 1 | command
# echo 1 | command
# echo 2 | command
# echo 1 | command
# echo n | command
# echo n | command

gsettings set org.gnome.desktop.wm.preferences button-layout ":minimize,maximize,close"
# Remove games
dnf remove -y gnome-games*
dnf remove -y aisleriot
dnf remove -y gnome-boxes
# Remove office programs
dnf remove -y libreoffice*

# Remove other non-essential programs (example)
dnf remove -y cheese rhythmbox gnome-clocks gnome-maps gnome-characters gnome-characters gnome-weather gnome-contacts gnome-tour
dnf remove -y firefox
dnf update -y

dnf install dnf-plugins-core

sudo dnf config-manager --add-repo https://brave-browser-rpm-release.s3.brave.com/brave-browser.repo

sudo rpm --import https://brave-browser-rpm-release.s3.brave.com/brave-core.asc

dnf install brave-browser brave-keyring -y

dnf install gnome-tweaks -y
dnf install papirus-icon-theme -y
dnf install gnome-shell-extensions -y
dnf install neofetch -y
dnf install btop -y
dnf install curl -y

dnf install qemu -y
dnf install libvirt virt-install -y
gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'


sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
sudo sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo'

wget https://github.com/catppuccin/gtk/releases/download/v0.6.1/Catppuccin-Frappe-Standard-Yellow-dark.zip ~/Downloads


wget https://befonts.com/wp-content/uploads/2018/08/product-sans.zip

unzip product-sans.zip

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
# curl -s https://packagecloud.io/install/repositories/ookla/speedtest-cli/script.rpm.sh | sudo bash
# dnf install speedtest
flatpak install -y flathub com.raggesilver.BlackBox
flatpak install -y flathub org.gnome.Extensions
flatpak install -y flathub com.discordapp.Discord
flatpak install -y flathub com.spotify.Client

quiet splash initcall_blacklist=amd_pstate_init amd_pstate.enable=0
git clone https://github.com/AdnanHodzic/auto-cpufreq.git
dnf install glib2-devel -y
cd auto-cpufreq && sudo ./auto-cpufreq-installer


echo i | command 
sudo auto-cpufreq --install
echo y | command 
systemctl status auto-cpufreq
echo q | command
cd ..

sudo reboot -f
