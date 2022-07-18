#!/bin/bash

#using this to git pull the following folders on my machine
#bash_scripts
#python
#tryhackme

#will add more folders as they are created

#git pull bash_scripts
echo "git pull bash_scripts"
sleep 30
cd ~/Programming/bash_scripts || exit
git pull

#git pull python
echo "git pull python"
sleep 30
cd ~/Programming/python || exit
git pull

#git pull tryhackme
echo "git pull tryhackme"
sleep 30
cd ~/Programming/tryhackme || exit
git pull