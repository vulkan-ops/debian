#!/usr/bin/env bash

#PPA_LUTRIS="ppa:lutris-team/lutris"
#PPA_lqx="deb http://ppa.launchpad.net/damentz/liquorix/ubuntu bionic main"
#PPA_lutris="deb http://ppa.launchpad.net/lutris-team/lutris/ubuntu bionic main"
#PPA_pkppa="deb http://ppa.launchpad.net/paulo-miguel-dias/pkppa/ubuntu bionic main"
URL_WINE_KEY="https://dl.winehq.org/wine-builds/winehq.key"
URL_PPA_WINE="https://dl.winehq.org/wine-builds/ubuntu/"
URL_GOOGLE_CHROME="https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb"
#URL_SIMPLE_NOTE="https://github.com/Automattic/simplenote-electron/releases/download/v1.8.0/Simplenote-linux-1.8.0-amd64.deb"
URL_4K_VIDEO_DOWNLOADER="https://dl.4kdownload.com/app/4kvideodownloader_4.9.2-1_amd64.deb"
#URL_INSYNC="https://d2t3ff60b2tol4.cloudfront.net/builds/insync_3.0.20.40428-bionic_amd64.deb"

downloads="$HOME/Downloads/programas"

install=(
#snapd
#mint-meta-codecs
winff
guvcview
#virtualbox
flameshot
zsh
fish
#nemo-dropbox
steam-installer
steam-devices
steam:i386
ratbagd
#piper
lutris
libvulkan1
libvulkan1:i386
libgnutls30:i386
libldap-2.4-2:i386
libgpg-error0:i386
libxml2:i386
libasound2-plugins:i386
libsdl2-2.0-0:i386
libfreetype6:i386
libdbus-1-3:i386
libsqlite3-0:i386
android-tools-adb
android-tools-fastboot
apparmor-profiles
apparmor-utils
audacity
cheese
#chromium-browser
clamtk
#deepin-terminal
gedit
#gnome-system-monitor
gparted
indicator-cpufreq
inkscape
manpages-fr-extra
manpages-pl
mpv
neofetch
prelink
scribus
#skypeforlinux
snap
#snapd
#spotify-client
sublime-text
tlp
whatsapp-desktop
wine-installer
zram-config
)

sudo rm /var/lib/dpkg/lock-frontend
sudo rm /var/cache/apt/archives/lock
sudo dpkg --add-architecture i386
sudo apt update -y
#sudo add-apt-repository "$PPA_lutris" -y
wget -nc "$URL_WINE_KEY"
sudo apt-key add winehq.key
sudo apt-add-repository "deb $URL_PPA_WINE bionic main"
#sudo apt-add-repository"$PPA_lqx" -y
sudo apt update -y
mkdir "$DIRETORIO_DOWNLOADS"
wget -c "$URL_GOOGLE_CHROME"       -P "$DIRETORIO_DOWNLOADS"
#wget -c "$URL_SIMPLE_NOTE"         -P "$DIRETORIO_DOWNLOADS"
wget -c "$URL_4K_VIDEO_DOWNLOADER" -P "$DIRETORIO_DOWNLOADS"
#wget -c "$URL_INSYNC"              -P "$DIRETORIO_DOWNLOADS"
sudo dpkg -i $downloads/*.deb

for nome_do_programa in ${install[@]}; do
  if ! dpkg -l | grep -q $nome_do_programa; then
    apt install "$nome_do_programa" -y
  else
    echo "[INSTALADO] - $nome_do_programa"
  fi
done

sudo apt install --install-recommends winehq-stable wine-stable wine-stable-i386 wine-stable-amd64 -y
sudo apt install libdvd-pkg && sudo dpkg-reconfigure libdvd-pkg
flatpak install flathub com.obsproject.Studio -y
sudo snap install spotify
sudo snap install slack --classic
sudo snap install skype --classic
sudo snap install photogimp
sudo apt update && sudo apt dist-upgrade -y
flatpak update
sudo apt autoclean
sudo apt autoremove -y
