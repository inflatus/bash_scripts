#!/bin/bash

#This script will determine the distribution of Linux and use the appropriate package manager to update applications I use

  current_distro=$(awk -F= '$1 == "ID" { print $2 }' /etc/*-release)
  close_distro=$(awk -F= '$1 == "ID_LIKE" { print $2 }' /etc/*-release)

  echo "$current_distro"
  echo "$close_distro"

if [ "$close_distro" = "debian" ]; then

  #Debian
  apt update
  apt dist-upgrade -y
  apt autoclean
  apt autoremove -y

else
  #Fedora
  dnf check-update -y
  dnf upgrade --refresh -y
  dnf clean all
  dnf autoremove -y

fi
