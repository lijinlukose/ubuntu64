#!/bin/bash
#Script v6.3.1
#This script is Free and Open Source as part of the FOSS initiative worldwide
# Setting up a Linux system for eDistrict and other Projects.
# Do not edit this script or the files/folders along with the script, as it may break the
# functionality of the script.
# If you are changing the files/folders, also make corresponding changes to the main script

#including the script for functions
source ~/Desktop/ubuntu64/scripts/functions64.sh

#DSC Menu
clear
show_report
response=$(zenity --list --title="DSCs [Script v6.3.1]" --text " " --column="0" \
"SafeSign (Moserbaer)" "ePass 2003" "ProxKey" "NICDSigner" "Go Back to Main Menu" "Quit" \
--height=250 --width=205 --hide-header 2>/dev/null)

if [ $? = 1 ] ; then
  exit
fi

#case for switching DSC Menu options
case $response in
    "SafeSign (Moserbaer)") 
      clear
      safesign_install
      dsc_menu;;
    "ePass 2003") 
      clear
      epass_install
      dsc_menu;;
    "ProxKey") 
      clear
      proxkey_install
      dsc_menu;;
    "NICDSigner") 
      clear
      nicd_install
      dsc_menu;;
    "Go Back to Main Menu") 
      main_menu;;
    "Quit") 
      exit;;
    *) exit;;
esac