#!/bin/bash

#Tested on Ubuntu 16.04 17.04
#Wireshark requires interaction during install
#Added Snaps to Debian

#Some distributions may not have the applications
#Part of the script may be redundant
#Added a section to remove unwanted applications

#Next step is to configure services that need starting

#This script will determine the distribution of Linux and use the appropriate package manager to install applications I use

  current_distro=$(awk -F= '$1 == "ID" { print $2 }' /etc/*-release)
  close_distro=$(awk -F= '$1 == "ID_LIKE" { print $2 }' /etc/*-release)

  echo "$current_distro"
  echo "$close_distro"

if [ "$close_distro" = "debian" ]; then
 
  #Debian
  #Remove unwanted applications
  echo "Removing unwanted applications"
  echo "------------------------------"
  apt-get remove --purge Thunderbird* -y
  apt-get remove --purge Empathy* -y
  apt-get remove --purge AisleRiot* -y
  apt-get remove --purge Brasero* -y
  apt-get remove --purge Mahjongg* -y
  apt-get remove --purge libreoffice* -y
  apt-get remove --purge openoffice* -y

  #Install applications on a fresh install of Debian based Linux
  echo "This script will install your apps after a fresh install"
  echo "--------------------------------------------------------"
  apt-get update && apt-get dist-upgrade -y
  apt-get install htop traceroute whois gparted curl nmap openvpn rsync iptraf openssh-client openssh-server git gimp hexchat unison atop bandwidthd uget vim python3-pip python-dev ethtool python-virtualenv tree wget glances -y

  #Add repositories
  echo "Adding the repositories"
  echo "-----------------------"
  add-apt-repository ppa:wireshark-dev/stable -y
  add-apt-repository ppa:transmissionbt/ppa:transmission-gtk -y
  add-apt-repository ppa:tails-team/tails-installer -y
  apt-get update
  apt-get install transmission-gtk wireshark tails-installer -y
  
  #Snaps
  snap install libreoffice -y
  snap install telegram-sergiusens -y
  snap install simplescreenrecorder-mardy -y
  snap install remmina -y
  snap install vlc -y
  snap install slack -y
  snap install gimp -y
  snap install discord -y
  snap install handbrake-jz -y

  #Add applications that require a different means of installation
  #Chrome
  echo "Chrome install"
  echo "--------------"
  apt-get install libxss1 libappindicator1 libindicator7
  wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
  dpkg -i google-chrome*.deb
  rm google-chrome-stable_current_amd64.deb
 
  #Youtube Downloader
  echo "Youtube Downloader"
  echo "------------------"
  wget https://yt-dl.org/downloads/latest/youtube-dl -O /usr/local/bin/youtube-dl
  chmod a=+rx /usr/local/bin/youtube-dl

  #YouCompleteMe
  echo "YouCompleteMe"
  echo "------------------"
  apt-get install build-essential cmake
  apt-get install python-dev python3-dev
  cd ~/.vim/bundle/YouCompleteMe
  ./install.py --clang-completer
  cd ~/.vim/bundle/YouCompleteMe
  ./install.py --all
  
  #Update all files
  echo "Updating all files"
  echo "------------------"
  apt-get update && apt-get dist-upgrade -y
  
  #Clean
  echo "Cleaning now"
  echo "------------"
  apt-get autoclean
  apt-get autoremove -y

  #Finish install
  echo "Finished."

else

  #Fedora / Still working on apps and install syntax / Need to test as well
  #Remove Unwanted Applications
  dnf remove libreoffice* -y
  dnf remove openoffice* -y

  #Install my apps on a fresh install of a Fedora based Linux
  echo "This script will install your apps after a fresh install"
  dnf check-update -y
  dnf upgrade --refresh -y
  dnf install htop traceroute jwhois gparted curl nmap openvpn rsync iptraf openssh-clients openssh-server git gimp wireshark-qt hexchat atop uget vim python3-pip python-devel ethtool python3-virtualenv tree transmission-gtk wget -y
  dnf clean all

  #Youtube Downloader
  echo "Youtube Downloader"
  echo "------------"
  wget https://yt-dl.org/downloads/latest/youtube-dl -O /usr/local/bin/youtube-dl
  chmod a+rx /usr/local/bin/youtube-dl

  #Chrome
  echo "Chrome"
  echo "------------"
  wget https://dl-ssl.google.com/linux/linux_signing_key.pub
  rpm --import linux_signing_key.pub
  sh -c 'echo "[google-chrome]
  name=Google Chrome 64-bit
  baseurl=http://dl.google.com/linux/chrome/rpm/stable/x86_64" >> /etc/yum.repos.d/google-chrome.repo'
  dnf check-update -y
  dnf install google-chrome -y

  #Handbrake
  echo "Handbrake"
  echo "------------"
  dnf groupinstall "Development Tools" "Development Libraries" -y
  dnf install bzip2-devel cmake fontconfig-devel freetype-devel fribidi-devel gcc-c++ git harfbuzz-devel jansson-devel lame-devel libass-devel libogg-devel libsamplerate-devel libtheora-devel libtool libvorbis-devel libxml2-devel m4 make opus-devel patch python tar x264-devel yasm zlib-devel -y
  dnf groupinstall "X Software Development" "GNOME Software Development" -y
  dnf install dbus-glib-devel gstreamer1-devel gstreamer1-plugins-base-devel intltool libgudev1-devel libnotify-devel webkitgtk3-devel -y
  git clone https://github.com/HandBrake/HandBrake.git && cd HandBrake
  ./configure --launch-jobs=$(nproc) --launch
  cd build && sudo make install

  #Remmina
  echo "Remmina"
  echo "------------"
  dnf copr enable hubbitus/remmina-next -y
  dnf upgrade --refresh 'remmina*' 'freerdp*' -y

  #LibreOffice 6.0.3
  echo "LibreOffice 6.0.3"
  echo "------------"
  wget http://mirror.clarkson.edu/tdf/libreoffice/stable/6.0.3/rpm/x86_64/LibreOffice_6.0.3_Linux_x86-64_rpm.tar.gz 
  tar zxvf LibreOffice_6.0.3_Linux_x86-64_rpm.tar.gz
  cd LibreOffice_6.0.3.2_Linux_x86-64_rpm/RPMS
  dnf install *.rpm -y

  #YouCompleteMe
  echo "YouCompleteMe"
  echo "------------"
  dnf install automake gcc gcc-c++ kernel-devel cmake -y
  dnf install python-devel python3-devel -y
  cd ~/.vim/bundle/YouCompleteMe
  ./install.py --clang-completer -y
  cd ~/.vim/bundle/YouCompleteMe
  ./install.py --all -y

  #Glances
  echo "Glances"
  echo "------------"
  wget -O- https://bit.ly/glances | /bin/bash

  #Update all files
  dnf check-update -y
  dnf upgrade --refresh -y

  #Time to clean
  echo "Alright, cleaning now."
  dnf clean all -y

  #Finished install
  echo "Finished."

fi
