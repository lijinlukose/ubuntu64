#!/bin/bash
#Script v6.3.1
#This script is Free and Open Source as part of the FOSS initiative worldwide
# Setting up a Linux system for eDistrict and other Projects.
# Do not edit this script or the files/folders along with the script, as it may break the
# functionality of the script.
# If you are changing the files/folders, also make corresponding changes to the main script

#The home page of the installation system

#including the script for functions used in main script
source ~/Desktop/ubuntu64/scripts/functions64.sh

#Main Menu
clear
choice=$(zenity --list --title="Main Menu [Script v6.3.1]" --text " " --column="0" \
       "Full Installation" "eDistrict Essentials" "DSCs" "Printers" "Optionals" \
       "Quit" --height=230 --width=230 --hide-header 2>/dev/null)

if [ $? = 1 ] ; then
  exit
fi

cd_scripts
#case for switching Main Menu options
case $choice in
  "Full Installation") 
    clear
    ./full_install.sh;;
  "eDistrict Essentials")
    clear
    ./edist_essentials.sh;;
  "DSCs") 
    clear
    ./dsc.sh;;
  "Printers") 
    clear
    ./printers.sh;;
  "Optionals") 
    clear
    ./optional_sw.sh;;
  "Quit") 
    exit;;
  *) exit;;
esac