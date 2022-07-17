#!/bin/bash
#Script v6.3.1
#This script is Free and Open Source as part of the FOSS initiative worldwide
# Setting up a Linux system for eDistrict and other Projects.
# Do not edit this script or the files/folders along with the script, as it may break the
# functionality of the script.
# If you are changing the files/folders, also make corresponding changes to the main script

#including the script for functions
source ~/Desktop/ubuntu64/scripts/functions64.sh

#Printers Menu
clear
show_report
response=$(zenity --list --title="Printers [Script v6.3.1]" --text " " --column="0" \
"Canon imageRUNNER 2002" "Canon imageCLASS LBP6230dn" "Kyocera TASKalfa 2201" "RICOH SP212SNw" "RICOH SP310SFN" \
"RICOH MP 1813L" "HP Printer (All Models)" "Go Back to Main Menu" "Quit" --height=300 \
--width=270 --hide-header 2>/dev/null)

if [ $? = 1 ] ; then
  exit
fi

#case for switching Printer Menu options
case $response in
    "Canon imageRUNNER 2002") 
      clear
      canon2002_install
      printer_menu;;
    "Canon imageCLASS LBP6230dn") 
      clear
      canon6230_install
      printer_menu;;
    "Kyocera TASKalfa 2201") 
      clear
      kyocera2201_install
      printer_menu;;  
    "RICOH SP212SNw") 
      clear
      ricoh212_install
      printer_menu;;
    "RICOH SP310SFN") 
      clear
      ricoh310_install
      printer_menu;;
    "RICOH MP 1813L") 
      clear
      ricoh1813_install
      printer_menu;;
    "HP Printer (All Models)") 
      clear
      hp_install
      printer_menu;;
    "Go Back to Main Menu") 
      main_menu;;
    "Quit") 
      exit;;
    *) exit;;
esac