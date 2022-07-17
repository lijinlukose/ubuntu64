#!/bin/bash
#Script v6.3.1
#This script is Free and Open Source as part of the FOSS initiative worldwide
# Setting up a Linux system for eDistrict and other Projects.
# Do not edit this script or the files/folders along with the script, as it may break the
# functionality of the script.
# If you are changing the files/folders, also make corresponding changes to the main script

#including the script for functions
source ~/Desktop/ubuntu64/scripts/functions64.sh

#eDistrict Essentials Menu
clear
show_report
response=$(zenity --list --title="eDistrict Essentials [Script v6.3.1]" \
--text " " --column="0" "Java JRE 8u261" "Adobe Reader" "ePass 2003" \
"ProxKey" "PaleMoon Browser" "Go Back to Main Menu" "Quit" --height=300 --width=300 \
--hide-header 2>/dev/null)

if [ $? = 1 ] ; then
  exit
fi

#case for switching eDistrict Essentials Menu options
case $response in
	"Java JRE 8u261") 
		clear
      	java_install
      	edist_menu;;
    "Adobe Reader") 
     	clear
     	adobe_install
     	edist_menu;;
   	"ePass 2003") 
     	clear
      	epass_install
      	edist_menu;;
	"ProxKey")
		clear
      	proxkey_install
      	edist_menu;;
    "PaleMoon Browser") 
      	clear
     	palemoon_install
      	edist_menu;;
    "Go Back to Main Menu") 
      	main_menu;;
    "Quit") 
		exit;;
    *) exit;;
  esac