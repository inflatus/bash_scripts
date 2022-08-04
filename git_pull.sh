#!/bin/bash

#using this to git pull the following folders on my machine
#bash_scripts
#python
#tryhackme
#picoctf

#will add more folders as they are created

#git pull bash_scripts
echo "git pull bash_scripts"
sleep 15
cd ~/Programming/bash_scripts || exit
git pull origin main

#git pull python
echo "git pull python"
sleep 15
cd ~/Programming/python || exit
git pull origin main

#git pull tryhackme
echo "git pull tryhackme"
sleep 15
cd ~/Programming/tryhackme || exit
git pull origin main

#git pull picoctf
echo "git pull picoctf"
sleep 15
cd ~/Programming/picoctf || exit
git pull origin main