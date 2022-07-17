#!/bin/bash
#Script v6.3.1
#This script is Free and Open Source as part of the FOSS initiative worldwide
# Setting up a Linux system for eDistrict and other Projects.
# Do not edit this script or the files/folders along with the script, as it may break the
# functionality of the script.
# If you are changing the files/folders, also make corresponding changes to the main script

#Script to install Optional softwares, if required

#including the script for functions
source ~/Desktop/ubuntu64/scripts/functions64.sh

#Optionals Menu
clear
show_report
response=$(zenity --list --title="Optionals [Script v6.3.1]" --text " " --column="0" \
"TeamViewer" "AnyDesk" "Google Chrome" "PaleMoon Browser" "PDFsam" "Zoom Desktop Client" "Kavach Authenticator" "NICDSigner" \
"Microsoft Teams" "GIMP" "VLC Media Player" "Unity Tweak Tool" "GNOME Tweak Tool" "Add Unity Icons (Ubuntu 16.04 only)" \
"Add GNOME Icons" "Utilities" "Malayalam Unicode Fonts" "Turn Off Guest Session (Ubuntu 16.04 only)" \
"Go Back to Main Menu" "Quit" --height=550 --width=325 --hide-header 2>/dev/null)

if [ $? = 1 ] ; then
  exit
fi

  #case for switching Optional Softwares Menu options
  case $response in
    "TeamViewer") 
      clear
      teamviewer_install
      optsoft_menu;;
    "AnyDesk") 
      clear
      anydesk_install
      optsoft_menu;;
    "Google Chrome") 
      clear
      chrome_install
      optsoft_menu;;
    "PaleMoon Browser") 
      clear
      palemoon_install
      optsoft_menu;;
    "PDFsam") 
      clear
      pdfsam_install
      optsoft_menu;;
    "Zoom Desktop Client")
      clear
      zoom_install
      optsoft_menu;;
    "Kavach Authenticator")
      clear
      kavach_install
      optsoft_menu;;
    "NICDSigner")
      clear
      nicd_install
      optsoft_menu;;
     "Microsoft Teams")
      clear
      teams_install
      optsoft_menu;;  
    "GIMP")
      clear
      gimp_install
      optsoft_menu;;
    "VLC Media Player")
      clear
      vlc_install
      optsoft_menu;;
    "Unity Tweak Tool")
      clear
      unitytweak_install
      optsoft_menu;;
    "GNOME Tweak Tool")
      clear
      gnometweak_install
      optsoft_menu;;
    "Add Unity Icons (Ubuntu 16.04 only)")
      clear
      unityicons
      optsoft_menu;;
    "Add GNOME Icons")
      clear
      gnomeicons
      optsoft_menu;;
    "Utilities") 
      clear
      util_install
      optsoft_menu;;
    "Malayalam Unicode Fonts")
      clear
      malfont_install
      optsoft_menu;;
    "Turn Off Guest Session (Ubuntu 16.04 only)")
      clear
      guestoff
      optsoft_menu;;
    "Go Back to Main Menu") 
      main_menu;;
    "Quit") 
      exit;;
    *) exit;;
  esac